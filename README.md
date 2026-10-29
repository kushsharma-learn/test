# Cloudflare zone + DNS records (Terraform)

Creates a Cloudflare zone and a set of DNS records using the
[Cloudflare Terraform provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest) v5.

## Files

| File | Purpose |
| --- | --- |
| `versions.tf` | Terraform and provider versions |
| `variables.tf` | Inputs: account ID, zone name/type, DNS records |
| `main.tf` | The `cloudflare_zone` and `cloudflare_dns_record` resources |
| `outputs.tf` | Zone ID, assigned name servers, record IDs |
| `terraform.tfvars.example` | Example inputs to copy |

## Usage

1. Create a Cloudflare API token with **Zone: Edit** and **DNS: Edit** permissions, then:
   ```sh
   export CLOUDFLARE_API_TOKEN="your-token"
   ```
2. Copy the example inputs and fill in your values:
   ```sh
   cp terraform.tfvars.example terraform.tfvars
   ```
3. Run:
   ```sh
   terraform init
   terraform plan
   terraform apply
   ```
4. Update your domain's name servers at your registrar to the values in the
   `name_servers` output. The zone becomes active once that change propagates.

## Adding records

Add an entry to `dns_records` in `terraform.tfvars`:

```hcl
blog = { name = "blog", type = "CNAME", content = "myblog.example.net", proxied = true }
```

- `name`: `"@"` for the zone apex, or a subdomain label (e.g. `"www"`).
- `ttl`: defaults to `1` (automatic). Proxied records always use automatic TTL.
- `priority`: required for `MX`, `SRV` and `URI` records.

`terraform.tfvars` and state files are git-ignored so secrets and state aren't committed.
