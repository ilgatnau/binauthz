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

# we need a role with permissions cloudkms.cryptoKeyVersions.viewPublicKey
resource "google_kms_crypto_key_iam_member" "binauthz_sigining_key" {
  for_each = toset(
    [
      "roles/cloudkms.publicKeyViewer",
      "roles/cloudkms.signer",
      "roles/cloudkms.signerVerifier",
      "roles/cloudkms.publicKeyViewer", # here to replace with custom role
    ]
  )
  crypto_key_id = google_kms_crypto_key.example-key.id
  role          = each.key
  member        = "serviceAccount:binauthz-sa@vm-import-346415.iam.gserviceaccount.com"
}