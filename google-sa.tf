resource "google_service_account" "ci-github-runner" {
  account_id   = "ci-github-runner"
  display_name = "ci-github-runner"
  description  = "SA for Github actions"
}
