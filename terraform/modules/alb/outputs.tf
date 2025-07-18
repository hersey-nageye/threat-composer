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

output "alb_listener_web" {
  description = "Listener for the Application Load Balancer on port 80"
  value       = aws_lb_listener.web.id

}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name

}

output "alb_zone_id" {
  description = "Zone ID of the Application Load Balancer"
  value       = aws_lb.alb.zone_id

}

