locals {
  lesempolem_backend_name = "lesempolem-backend"
}

resource "google_service_account" "lesempolem_backend" {
  account_id   = "cloudrun-${local.lesempolem_backend_name}"
  display_name = "SA for ${local.lesempolem_backend_name} cloud run"
}

resource "google_cloud_run_service" "lesempolem_backend" {
  name     = local.lesempolem_backend_name
  location = "europe-west1"

  metadata {
    namespace   = var.GOOGLE_PROJECT_ID
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
        image = "eu.gcr.io/${var.GOOGLE_PROJECT_ID}/kotrzina/lesempolem-backend@sha256:b64d03be398f7b4d50e841061bb578552a2981c7e3437b8031509fbb1fb03103"
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
          name  = "GOOGLE_FIRESTORE_COLLECTION_PREFIX"
          value = "lesempolem-backend-"
        }

      }
      service_account_name = google_service_account.lesempolem_backend.email
      timeout_seconds      = 5
    }
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["run.googleapis.com/operation-id"],
    ]
  }
}

resource "google_cloud_run_service_iam_member" "lesempolem_backend" {
  location = google_cloud_run_service.lesempolem_backend.location
  project  = google_cloud_run_service.lesempolem_backend.project
  service  = google_cloud_run_service.lesempolem_backend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "lesempolem_backend_url" {
  value = google_cloud_run_service.lesempolem_backend.status.0.url
}
