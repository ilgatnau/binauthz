resource "google_service_account" "service_account" {
  account_id   = "binauthz-sa"
  display_name = "Binauthz Service Account"
  project = "vm-import-346415"
}