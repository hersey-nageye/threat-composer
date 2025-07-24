variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)

}

variable "project_name" {
  description = "Name of the project, used for tagging resources"
  type        = string

}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)

}

variable "subnet_availability_zones" {
  description = "List of availability zones to use for subnets"
  type        = list(string)

}

variable "alb_sg_name" {
  description = "Name of the security group for the Application Load Balancer"
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

variable "target_group_name" {
  description = "Name of the target group for the ALB"
  type        = string

}

variable "ecs_sg_name" {
  description = "Name of the ECS security group"
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

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string

}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for drhersey.org"
  type        = string

}

variable "domain_with_subdomain" {
  description = "The domain name with subdomain for the Route53 record"
  type        = string

}


