
# ACM

resource "aws_acm_certificate" "main_certificate" {
  domain_name       = var.domain_with_subdomain
  validation_method = "DNS"

  subject_alternative_names = [
    var.domain_with_subdomain,
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-acm-certificate"
  })
}

resource "aws_acm_certificate_validation" "main_validation" {
  certificate_arn         = aws_acm_certificate.main_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  depends_on = [aws_route53_record.cert_validation]
}

# Route53

resource "aws_route53_zone" "main" {
  name = var.domain_with_subdomain

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-main-hosted-zone"
  })
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.main_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}

# resource "aws_route53_record" "app" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = var.domain_with_subdomain
#   type    = "A"

#   alias {
#     name                   = var.alb_dns_name
#     zone_id                = var.alb_zone_id
#     evaluate_target_health = true
#   }
# }

