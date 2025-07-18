output "route53_nameservers" {
  value       = module.certificate.hosted_zone_name_servers
  description = "Route53 nameservers for drhersey.org"
}
