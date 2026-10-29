output "zone_id" {
  description = "ID of the created zone"
  value       = cloudflare_zone.this.id
}

output "name_servers" {
  description = "Set these at your domain registrar to activate the zone"
  value       = cloudflare_zone.this.name_servers
}

output "dns_record_ids" {
  description = "IDs of the created DNS records, keyed by label"
  value       = { for k, r in cloudflare_dns_record.this : k => r.id }
}
