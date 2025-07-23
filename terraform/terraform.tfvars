# Tags

common_tags = {
  Project = "Threat Composer"
  Owner   = "Hersey Nageye"
}

project_name = "ecs-project"

# VPC

vpc_cidr                  = "10.0.0.0/16"
subnet_availability_zones = ["eu-west-2a", "eu-west-2b"]
public_subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24"]

# ALB

alb_sg_name       = "alb-security-group"
cidr_ipv4         = "0.0.0.0/0"
alb_name          = "my-alb"
target_group_name = "app-target-group"

# ECS

ecs_sg_name         = "ecs-security-group"
ecs_cluster_name    = "my-cluster"
task_family_name    = "my-task-family"
cpu_units           = "1024"
memory_size         = "3072"
service_name        = "main-service"
desired_count       = 1
container_name      = "my-container"
container_port      = 3000
container_image_url = "816069169238.dkr.ecr.eu-west-2.amazonaws.com/ecs-project:v2"

# Certificate / DNS
domain_name           = "drhersey.org"
domain_with_subdomain = "tm.drhersey.org"



# Cloudflare 
cloudflare_zone_id = "1804c4a001148cf6c658deb8e4b31370"
