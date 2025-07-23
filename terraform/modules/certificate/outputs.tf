output "certificate_arn" {
  value       = aws_acm_certificate_validation.main_validation.certificate_arn
  description = "The ARN of the main ACM certificate."

}

output "certificate_validation" {
  value       = aws_acm_certificate_validation.main_validation
  description = "The ACM certificate validation resource."

}

output "domain_validation_options" {
  value       = aws_acm_certificate.main_certificate.domain_validation_options
  description = "The domain validation options for the ACM certificate."

}
