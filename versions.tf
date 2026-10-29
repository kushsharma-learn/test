terraform {
  required_version = ">= 1.3"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "cloudflare" {
  # Reads the API token from the CLOUDFLARE_API_TOKEN environment variable.
}
