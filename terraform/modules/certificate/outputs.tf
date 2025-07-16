output "main_certificate_arn" {
  value       = aws_acm_certificate.main_certificate.arn
  description = "The ARN of the main ACM certificate."

}

output "main_certificate_validation" {
  value       = aws_acm_certificate_validation.main_validation
  description = "The ACM certificate validation resource."

}

output "cert_validation_records" {
  value       = aws_route53_record.cert_validation
  description = "The Route53 records for ACM certificate validation."

}

output "domain_validation_options" {
  value       = aws_acm_certificate.main_certificate.domain_validation_options
  description = "The domain validation options for the ACM certificate."

}

output "main_zone_id" {
  value       = aws_route53_zone.main.zone_id
  description = "The ID of the main Route53 hosted zone."

}

output "hosted_zone_name_servers" {
  description = "Route53 hosted zone name servers"
  value       = aws_route53_hosted_zone.main.name_servers
}
