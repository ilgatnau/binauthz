resource "google_binary_authorization_policy" "policy" {
  project = google_project.binauthz_client.project_id

  admission_whitelist_patterns {
    name_pattern = "gcr.io/google_containers/*"
  }

  default_admission_rule {
    evaluation_mode         = "REQUIRE_ATTESTATION"
    enforcement_mode        = "ENFORCED_BLOCK_AND_AUDIT_LOG"
    require_attestations_by = [google_binary_authorization_attestor.attestor.id]
  }

  global_policy_evaluation_mode = "ENABLE"
}

# resource "google_binary_authorization_attestor_iam_member" "member" {
#   project  = google_project.attestation.project_id
#   attestor = google_binary_authorization_attestor.attestor.name
#   role     = "roles/viewer"
#   member   = "serviceAccount:service-${google_project.binauthz_client.number}@gcp-sa-binaryauthorization.iam.gserviceaccount.com"
# }