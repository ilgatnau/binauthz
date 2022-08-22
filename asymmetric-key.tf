resource "google_kms_crypto_key" "example-key" {
  name            = "asymmetric-key-example"
  key_ring        = google_kms_key_ring.keyring.id
  purpose  = "ASYMMETRIC_SIGN"

  version_template {
    algorithm = "RSA_SIGN_PSS_4096_SHA512"
  }

  lifecycle {
    prevent_destroy = true
  }
}

data "google_kms_crypto_key_version" "my_crypto_key_version" {
  crypto_key = google_kms_crypto_key.example-key.id
}