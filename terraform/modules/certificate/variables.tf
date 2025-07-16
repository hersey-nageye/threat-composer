variable "domain_name" {
  description = "The primary domain name for the ACM certificate."
  type        = string

}

variable "domain_with_subdomain" {
  description = "The domain name with subdomain for the Route53 record."
  type        = string

}

variable "common_tags" {
  description = "Common tags to apply to all resources."
  type        = map(string)

}

variable "project_name" {
  description = "The name of the project, used for tagging resources."
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
