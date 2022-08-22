resource "google_service_account" "service_account" {
  account_id   = "binauthz-sa"
  display_name = "Binauthz Service Account"
  project = "vm-import-346415"
}

resource "google_service_account" "attestor_service_account" {
  account_id   = "binauthz-sa"
  display_name = "Binauthz Service Account"
  project = google_project.attestor.project_id
}