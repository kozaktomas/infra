resource "google_artifact_registry_repository" "kotrzina" {
  location      = "europe-west1"
  repository_id = "kotrzina"
  description   = "kotrzina docker repository"
  format        = "DOCKER"
}
