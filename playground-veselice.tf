variable "PLAYGROUND_VESELICE_JWT_SIGNING_KEY" {
  type        = string
  description = "JWT signing key"
  sensitive   = true
}

variable "PLAYGROUND_VESELICE_REGISTRATION_CODE" {
  type        = string
  description = "Password for registration"
  sensitive   = true
}

variable "PLAYGROUND_VESELICE_ADMINS" {
  type        = string
  description = "Comma separated list of admins"
  sensitive   = true
}

variable "PLAYGROUND_VESELICE_DISCORD_URL" {
  type        = string
  description = "Discord notification hook url"
  sensitive   = true
}

locals {
  playground_veselice_name = "playground-veselice"
}

resource "google_service_account" "playground_veselice" {
  account_id   = "cloudrun-${local.playground_veselice_name}"
  display_name = "SA for ${local.playground_veselice_name} cloud run"
}

# https://cloud.google.com/firestore/docs/security/iam
resource "google_project_iam_binding" "playground_veselice" {
  role    = "roles/datastore.user"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.playground_veselice.email}"
  ]
}

resource "google_cloud_run_service" "playground_veselice" {
  name     = local.playground_veselice_name
  location = "europe-west1"

  metadata {
    namespace = var.GOOGLE_PROJECT_ID
    annotations = {
      "run.googleapis.com/ingress"        = "all"
      "run.googleapis.com/ingress-status" = "all"
    }
  }

  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale" = "0"
        "autoscaling.knative.dev/maxScale" = "3"
        "run.googleapis.com/client-name"   = "terraform"
      }
    }
    spec {
      containers {
        image = "eu.gcr.io/${var.GOOGLE_PROJECT_ID}/kotrzina/court-reservations@sha256:b08e02d10e7fee6f9b420484b5b94e0b8c4c83f45d56618d88e0b2966e23f228"
        ports {
          name           = "http1"
          container_port = 8080
        }
        resources {
          limits = {
            cpu    = "1000m"
            memory = "128Mi"
          }
        }
        env {
          name  = "GOOGLE_PROJECT_ID"
          value = var.GOOGLE_PROJECT_ID
        }

        env {
          name  = "FIRESTORE_COLLECTION_RESERVATIONS"
          value = "${local.playground_veselice_name}-reservations"
        }

        env {
          name  = "FIRESTORE_COLLECTION_USERS"
          value = "${local.playground_veselice_name}-users"
        }

        env {
          name  = "JWT_SIGNING_KEY"
          value = var.PLAYGROUND_VESELICE_JWT_SIGNING_KEY
        }

        env {
          name  = "REGISTRATION_CODE"
          value = var.PLAYGROUND_VESELICE_REGISTRATION_CODE
        }

        env {
          name  = "ADMINS"
          value = var.PLAYGROUND_VESELICE_ADMINS
        }

        env {
          name  = "NOTIFICATION_DISCORD"
          value = var.PLAYGROUND_VESELICE_DISCORD_URL
        }
      }
      service_account_name = google_service_account.playground_veselice.email
      timeout_seconds      = 5
    }
  }
}

resource "google_cloud_run_service_iam_member" "playground_veselice" {
  location = google_cloud_run_service.playground_veselice.location
  project  = google_cloud_run_service.playground_veselice.project
  service  = google_cloud_run_service.playground_veselice.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "playground_veselice_url" {
  value = google_cloud_run_service.playground_veselice.status.0.url
}
