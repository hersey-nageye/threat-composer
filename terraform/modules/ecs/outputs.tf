output "ecs_sg_id" {
  description = "Security group ID for ECS tasks"
  value       = aws_security_group.ecs_tasks_sg.id

}

output "aws_cloudwatch_log_group_name" {
  description = "Name of the CloudWatch log group for ECS tasks"
  value       = aws_cloudwatch_log_group.ecs_logs.name

}

output "cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.my-cluster.id

}
