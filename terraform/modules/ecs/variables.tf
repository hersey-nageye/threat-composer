variable "ecs_sg_name" {
  description = "Name of the ECS security group"
  type        = string

}

variable "vpc_id" {
  description = "VPC ID where ECS resources will be created"
  type        = string

}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)

}

variable "project_name" {
  description = "Name of the project"
  type        = string

}

variable "alb_sg_id" {
  description = "Security group ID for the Application Load Balancer"
  type        = string

}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string

}

variable "task_family_name" {
  description = "Family name for the ECS task definition"
  type        = string

}

variable "cpu_units" {
  description = "CPU units for the ECS task"
  type        = string

}

variable "memory_size" {
  description = "Memory size for the ECS task"
  type        = string

}

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string

}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string

}

variable "container_name" {
  description = "Name of the container in the ECS task definition"
  type        = string

}

variable "container_port" {
  description = "Port on which the container listens"
  type        = number

}

variable "container_image_url" {
  description = "URL of the container image"
  type        = string

}

variable "service_name" {
  description = "Name of the ECS service"
  type        = string

}

variable "desired_count" {
  description = "Desired number of ECS task instances"
  type        = number

}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ECS service"
  type        = list(string)

}

variable "target_group_arn" {
  description = "ARN of the target group for the ECS service"
  type        = string

}

variable "alb_listener_web" {
  description = "ALB listener for web traffic"
  type        = any

}
