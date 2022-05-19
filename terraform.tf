variable "CLOUDFLARE_EMAIL" {
  type        = string
  description = "Cloudflare email"
}

variable "CLOUDFLARE_API_KEY" {
  type        = string
  description = "Cloudflare API key"
}

variable "GOOGLE_PROJECT_ID" {
  type        = string
  description = "Google project ID (e.g. project-name-346616)"
}

terraform {
  backend "http" {
    address        = "https://gitlab.com/api/v4/projects/30017932/terraform/state/infra"
    lock_address   = "https://gitlab.com/api/v4/projects/30017932/terraform/state/infra/lock"
    lock_method    = "POST"
    unlock_address = "https://gitlab.com/api/v4/projects/30017932/terraform/state/infra/lock"
    unlock_method  = "DELETE"
    retry_wait_min = 5
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

provider "cloudflare" {
  email   = var.CLOUDFLARE_EMAIL
  api_key = var.CLOUDFLARE_API_KEY
}

provider "google" {
  project = var.GOOGLE_PROJECT_ID
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_container_registry" "registry" {
  project  = var.GOOGLE_PROJECT_ID
  location = "EU"
}

