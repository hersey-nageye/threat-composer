# ECS - This module sets up an ECS cluster, task definition, and service with a security group for tasks.

# Data source to get the current AWS region
data "aws_region" "current" {}

# Security group for ECS tasks with ingress and egress rules
resource "aws_security_group" "ecs_tasks_sg" {
  name        = var.ecs_sg_name
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id
  tags = merge(var.common_tags, {
    Name = "${var.project_name}-ecs-tasks-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "container_port" {
  security_group_id = aws_security_group.ecs_tasks_sg.id

  referenced_security_group_id = var.alb_sg_id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_ecs" {
  security_group_id = aws_security_group.ecs_tasks_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ECS Cluster for running tasks
resource "aws_ecs_cluster" "my-cluster" {
  name = var.ecs_cluster_name

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-ecs-cluster"
  })
}

# CloudWatch Log Group for ECS task logs
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.task_family_name}"
  retention_in_days = 7

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-ecs-logs"
  })
}

# ECS Task Definition for defining the task's properties
resource "aws_ecs_task_definition" "my-task" {
  family                   = var.task_family_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu_units
  memory                   = var.memory_size
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  container_definitions = jsonencode([
    {
      name  = var.container_name
      image = var.container_image_url

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

# ECS Service to run the task definition
resource "aws_ecs_service" "main" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.my-cluster.id
  task_definition = aws_ecs_task_definition.my-task.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks_sg.id]
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  depends_on = [var.alb_listener_web, aws_cloudwatch_log_group.ecs_logs]

  lifecycle {
    replace_triggered_by = [aws_ecs_task_definition.my-task.revision]
  }
}
