locals {
  lesempolem_backend_name = "lesempolem-backend"
}

resource "google_service_account" "lesempolem_backend" {
  account_id   = "cloudrun-${local.lesempolem_backend_name}"
  display_name = "SA for ${local.lesempolem_backend_name} cloud run"
}

# https://cloud.google.com/firestore/docs/security/iam
resource "google_project_iam_binding" "lesempolem_backend" {
  role    = "roles/datastore.user"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.lesempolem_backend.email}"
  ]
}

resource "google_cloud_run_service" "lesempolem_backend" {
  name     = local.lesempolem_backend_name
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
        image = "eu.gcr.io/${var.GOOGLE_PROJECT_ID}/kotrzina/lesempolem-backend@sha256:1de2e94695170cd892d8adddf77f42a5750111eac0386b1235be4d0db5d81fe7"
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
          value = "lesempolem-backend"
        }

      }
      service_account_name = google_service_account.lesempolem_backend.email
      timeout_seconds      = 5
    }
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
