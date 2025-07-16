output "route53_nameservers" {
  value       = module.certificate.hosted_zone_nameservers
  description = "Route53 nameservers for drhersey.org"
}
