# DNS - This module manages DNS records in AWS Route 53.

# AWS Route 53 DNS record for the Threat Command application
resource "aws_route53_record" "app" {
  zone_id = var.hosted_zone_id
  name    = var.domain_with_subdomain
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
