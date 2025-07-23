module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                  = var.vpc_cidr
  common_tags               = var.common_tags
  project_name              = var.project_name
  public_subnet_cidrs       = var.public_subnet_cidrs
  subnet_availability_zones = var.subnet_availability_zones

}

module "iam" {
  source = "./modules/iam"

  common_tags  = var.common_tags
  project_name = var.project_name

}

module "alb" {
  source = "./modules/alb"

  alb_sg_name         = var.alb_sg_name
  vpc_id              = module.vpc.vpc_id
  common_tags         = var.common_tags
  project_name        = var.project_name
  cidr_ipv4           = var.cidr_ipv4
  alb_name            = var.alb_name
  public_subnet_ids   = module.vpc.public_subnet_ids
  target_group_name   = var.target_group_name
  acm_certificate_arn = module.certificate.certificate_arn

}

module "ecs" {
  source = "./modules/ecs"

  ecs_sg_name                 = var.ecs_sg_name
  vpc_id                      = module.vpc.vpc_id
  common_tags                 = var.common_tags
  project_name                = var.project_name
  alb_sg_id                   = module.alb.alb_security_group_id
  ecs_cluster_name            = var.ecs_cluster_name
  task_family_name            = var.task_family_name
  cpu_units                   = var.cpu_units
  memory_size                 = var.memory_size
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.iam.ecs_task_role_arn
  alb_listener_web            = module.alb.alb_listener_web
  service_name                = var.service_name
  desired_count               = var.desired_count
  public_subnet_ids           = module.vpc.public_subnet_ids
  target_group_arn            = module.alb.target_group_arn
  container_name              = var.container_name
  container_image_url         = var.container_image_url
  container_port              = var.container_port


}

module "certificate" {
  source = "./modules/certificate"
  providers = {
    aws        = aws
    cloudflare = cloudflare
  }

  domain_with_subdomain = var.domain_with_subdomain
  common_tags           = var.common_tags
  project_name          = var.project_name
  cloudflare_zone_id    = var.cloudflare_zone_id
}

module "dns" {
  source = "./modules/dns"

  cloudflare_zone_id = var.cloudflare_zone_id
  alb_dns_name       = module.alb.alb_dns_name

  # Ensure certificate is validated before creating DNS record
  depends_on = [module.certificate]
}




























