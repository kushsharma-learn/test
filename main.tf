resource "cloudflare_zone" "this" {
  account = {
    id = var.account_id
  }
  name = var.zone_name
  type = var.zone_type
}

resource "cloudflare_dns_record" "this" {
  for_each = var.dns_records

  zone_id = cloudflare_zone.this.id
  # Use the fully-qualified name so Terraform doesn't report perpetual diffs.
  name     = each.value.name == "@" ? var.zone_name : "${each.value.name}.${var.zone_name}"
  type     = each.value.type
  content  = each.value.content
  ttl      = each.value.proxied ? 1 : each.value.ttl
  proxied  = each.value.proxied
  priority = each.value.priority
  comment  = each.value.comment
}
