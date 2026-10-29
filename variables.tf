variable "account_id" {
  description = "Cloudflare account ID that will own the zone"
  type        = string
}

variable "zone_name" {
  description = "Domain name for the zone, e.g. example.com"
  type        = string
}

variable "zone_type" {
  description = "Zone type: full, partial, secondary or internal"
  type        = string
  default     = "full"

  validation {
    condition     = contains(["full", "partial", "secondary", "internal"], var.zone_type)
    error_message = "zone_type must be one of: full, partial, secondary, internal."
  }
}

variable "dns_records" {
  description = "DNS records to create, keyed by a unique label"
  type = map(object({
    name     = string                 # "@" for the apex, or a subdomain like "www"
    type     = string                 # A, AAAA, CNAME, MX, TXT, ...
    content  = string
    ttl      = optional(number, 1)    # 1 = automatic
    proxied  = optional(bool, false)
    priority = optional(number)       # required for MX, SRV and URI records
    comment  = optional(string)
  }))
  default = {}
}
