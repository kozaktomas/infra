# https://cloud.google.com/firestore/docs/security/iam
resource "google_project_iam_binding" "gcp_firestore_admin" {
  role    = "roles/datastore.user"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.lesempolem_backend.email}",
    "serviceAccount:${google_service_account.playground_veselice.email}",
  ]
}
