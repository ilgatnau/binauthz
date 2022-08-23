resource "google_kms_key_ring" "keyring" {
  name     = "keyring-example"
  location = "global"
  project = "vm-import-346415"
}

resource "google_project_iam_custom_role" "my-custom-role" {
  project = "vm-import-346415"
  role_id     = "get_key_versions"
  title       = "Custom role to get the key version"
  description = "Custom role to get the key version"
  permissions = [
    "cloudkms.cryptoKeys.get", 
    "cloudkms.cryptoKeyVersions.get", 
    "cloudkms.cryptoKeyVersions.list"
    ]
}