output "dns_record_id" {
  value       = cloudflare_dns_record.app.id
  description = "The ID of the Cloudflare DNS record"
}
