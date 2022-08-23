resource "google_service_account" "attestor_service_account" {
  account_id   = "binauthz-sa"
  display_name = "Binauthz Service Account"
  project = google_project.attestor.project_id
}

resource "google_project_iam_member" "sa_attestor" {
  project = google_project.attestor.project_id

  for_each = toset(
    [
      "roles/binaryauthorization.attestorsViewer",
      "roles/cloudkms.signerVerifier",
      "roles/containeranalysis.notes.attacher",
      "roles/containeranalysis.occurrences.editor", 
      "roles/containeranalysis.notes.occurrences.viewer",
    ]
  )

  role    = each.key
  member  = "serviceAccount:binauthz-sa@binauthz-attestor-test-project.iam.gserviceaccount.com"
}

resource "google_project_iam_member" "sa_attestation" {
  project = google_project.attestation.project_id

  for_each = toset(
    [
      "roles/binaryauthorization.attestorsViewer",
      "roles/cloudkms.signerVerifier",
      "roles/containeranalysis.notes.attacher",
      "roles/containeranalysis.occurrences.editor",
      "roles/containeranalysis.notes.occurrences.viewer",
    ]
  )

  role    = each.key
  member  = "serviceAccount:binauthz-sa@binauthz-attestor-test-project.iam.gserviceaccount.com"
}