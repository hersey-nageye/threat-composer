output "route53_nameservers" {
  value       = aws_route53_zone.main.name_servers
  description = "Route53 nameservers for drhersey.org"
}
