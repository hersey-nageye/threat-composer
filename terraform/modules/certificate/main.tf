# ACM Certificate Setup - This module provisions an ACM certificate for a domain with subdomain and uses Cloudflare for DNS validation.

# ACM Certificate for the subdomain
resource "aws_acm_certificate" "main_certificate" {
  domain_name       = var.domain_with_subdomain
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-acm-certificate"
  })
}

# Cloudflare DNS records for ACM certificate validation
resource "cloudflare_dns_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  content = each.value.record
  type    = each.value.type
  ttl     = 60
}

# DNS Validation for the ACM Certificate using Cloudflare records
resource "aws_acm_certificate_validation" "main_validation" {
  certificate_arn         = aws_acm_certificate.main_certificate.arn
  validation_record_fqdns = [for record in cloudflare_dns_record.cert_validation : record.name]

  depends_on = [cloudflare_dns_record.cert_validation]
}

