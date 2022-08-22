data "google_kms_crypto_key_version" "attestor-key-version" {
  crypto_key = "projects/vm-import-346415/locations/global/keyRings/keyring-example/cryptoKeys/asymmetric-key-example"
}

resource "google_binary_authorization_attestor" "attestor" {
  project = google_project.attestor.project_id
  name    = "demo-attestor"
  attestation_authority_note {
    note_reference = google_container_analysis_note.note.name
    public_keys {
      id = data.google_kms_crypto_key_version.attestor-key-version.id
      pkix_public_key {
        public_key_pem      = data.google_kms_crypto_key_version.attestor-key-version.public_key[0].pem
        signature_algorithm = data.google_kms_crypto_key_version.attestor-key-version.public_key[0].algorithm
      }
    }
  }
}

#### Vulnerability Analysis Note
resource "google_container_analysis_note" "note" {
  project = google_project.attestor.project_id
  name    = "test-attestor-note"
  attestation_authority {
    hint {
      human_readable_name = "Attestor Note"
    }
  }
}