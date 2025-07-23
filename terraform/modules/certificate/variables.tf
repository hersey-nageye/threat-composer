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

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for drhersey.org"
  type        = string

}
