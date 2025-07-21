
output "task-execution-role-name" {
  value       = aws_iam_role.ecs_task_execution_role.name
  description = "The name of the ECS task execution role"

}

output "ecs_task_execution_role_arn" {
  value       = aws_iam_role.ecs_task_execution_role.arn
  description = "ARN of the ECS task execution role"
}

output "ecs_task_role_arn" {
  value       = aws_iam_role.ecs_task_role.arn
  description = "ARN of the ECS task role"
}
