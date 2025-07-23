# DNS - This module manages DNS records in Cloudflare.

# Cloudflare DNS record for the subdomain pointing to ALB
resource "cloudflare_dns_record" "app" {
  zone_id = var.cloudflare_zone_id
  name    = "tm"
  content = var.alb_dns_name
  type    = "CNAME"
  ttl     = 300
  proxied = false
}
