resource "google_service_account" "miluji_praci" {
  account_id   = "cloudrun-miluji-praci"
  display_name = "SA for miluji_praci cloud run"
}

resource "google_cloud_run_service" "miluji_praci" {
  name     = "miluji-praci-fusakla"
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
      timeout_seconds      = 5
      service_account_name = google_service_account.miluji_praci.email
      containers {
        image = "eu.gcr.io/${var.GOOGLE_PROJECT_ID}/fusakla/slash-milujipraci@sha256:ec5781bf88de36db9567524cb976963e9454606e6540c69909b6d398b891e854"
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
      }
    }
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["run.googleapis.com/operation-id"],
    ]
  }
}

resource "google_cloud_run_service_iam_member" "miluji_praci" {
  location = google_cloud_run_service.miluji_praci.location
  project  = google_cloud_run_service.miluji_praci.project
  service  = google_cloud_run_service.miluji_praci.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_domain_mapping" "miluji_praci_kozak_in" {
  location = "europe-west1"
  name     = "milujipraci.kozak.in"
  metadata {
    namespace = google_cloud_run_service.miluji_praci.metadata.0.namespace
  }
  spec {
    route_name = google_cloud_run_service.miluji_praci.name
  }
}
