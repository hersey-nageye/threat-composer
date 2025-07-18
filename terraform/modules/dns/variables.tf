variable "hosted_zone_id" {
  description = "ID of the Route53 hosted zone"
  type        = string

}

variable "domain_with_subdomain" {
  description = "The domain name with subdomain for the Route53 record"
  type        = string

}

variable "alb_dns_name" {
  description = "ALB DNS name"
  type        = string

}

variable "alb_zone_id" {
  description = "ALB zone ID"
  type        = string

}
