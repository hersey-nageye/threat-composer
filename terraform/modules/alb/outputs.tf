output "alb_security_group_id" {
  description = "ID of the Application Load Balancer security group"
  value       = aws_security_group.alb_sg.id

}

output "alb_id" {
  description = "ID of the Application Load Balancer"
  value       = aws_lb.alb.id
}

output "target_group_arn" {
  description = "ARN of the Application Load Balancer target group"
  value       = aws_lb_target_group.app.arn

}

