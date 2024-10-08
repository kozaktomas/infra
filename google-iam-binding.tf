resource "google_project_iam_binding" "cloud_run_admin" {
  role    = "roles/run.admin"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.ci-github-runner.email}",
  ]
}

resource "google_project_iam_binding" "service_account_admin" {
  role    = "roles/iam.serviceAccountAdmin"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.ci-github-runner.email}",
  ]
}

resource "google_project_iam_binding" "compute_admin" {
  role    = "roles/compute.admin"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.ci-github-runner.email}",
  ]
}

resource "google_project_iam_binding" "organization_admin" {
  role    = "roles/resourcemanager.organizationAdmin"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.ci-github-runner.email}",
  ]
}

resource "google_project_iam_binding" "storage_admin" {
  role    = "roles/storage.admin"
  project = var.GOOGLE_PROJECT_ID
  members = [
    "serviceAccount:${google_service_account.ci-github-runner.email}",
  ]
}
