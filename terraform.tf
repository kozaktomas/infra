locals {
  vps_ipv4 = "88.99.13.74"
  vps_ipv6 = "2a01:4f8:c013:886a::1"
}

variable "CLOUDFLARE_ACCOUNT_ID" {
  type        = string
  description = "Cloudflare account ID"
  sensitive   = true
}

variable "CLOUDFLARE_EMAIL" {
  type        = string
  description = "Cloudflare email"
  sensitive   = true
}

variable "CLOUDFLARE_API_KEY" {
  type        = string
  description = "Cloudflare API key"
  sensitive   = true
}

variable "GOOGLE_PROJECT_ID" {
  type        = string
  description = "Google project ID (e.g. project-name-346616)"
  sensitive   = true
}

variable "MINIO_HOST" {
  type        = string
  description = "Personal Minio server host"
}

variable "MINIO_USER" {
  type        = string
  description = "Personal Minio server username"
}

variable "MINIO_PASSWORD" {
  type        = string
  description = "Personal Minio server password"
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
    minio = {
      source = "aminueza/minio"
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

provider "aws" {
  region = "eu-west-2"
}

provider "minio" {
  minio_server   = var.MINIO_HOST
  minio_user     = var.MINIO_USER
  minio_password = var.MINIO_PASSWORD
  minio_ssl      = true
}