resource "google_kms_key_ring" "keyring" {
  name     = "keyring-example"
  location = "global"
  project = "vm-import-346415"
}