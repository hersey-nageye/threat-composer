variable "alb_sg_name" {
  description = "Name of the security group for the Application Load Balancer"
  type        = string

}

variable "vpc_id" {
  description = "VPC ID where the ALB will be created"
  type        = string

}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)

}

variable "project_name" {
  description = "Project name to use in resource names"
  type        = string

}

variable "cidr_ipv4" {
  description = "CIDR block for the ALB security group ingress rules"
  type        = string

}

variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string

}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)

}

variable "target_group_name" {
  description = "Name of the target group for the ALB"
  type        = string

}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  type        = string

}
