resource "google_project" "for_service_account" {
  name       = "Project to store SA"
  project_id = "binauthz-sa-project"
  org_id     = "160037278965"

  billing_account = "01A2F5-73127B-50AE5B"
}

resource "google_project_service" "apis_seed_project" {
  project = google_project.for_service_account.project_id
  for_each = toset(
    [
      "cloudresourcemanager.googleapis.com",
      "iam.googleapis.com",
      "cloudkms.googleapis.com",
    ]
  )
  service = each.key
}

resource "google_project" "attestor" {
  name       = "Attestor Project"
  project_id = "binauthz-attestor-test-project"
  org_id     = "160037278965"

  billing_account = "01A2F5-73127B-50AE5B"

  depends_on = [
    google_project.for_service_account
  ]
}

resource "google_project" "binauthz_client" {
  name       = "Attestor Project"
  project_id = "binauthz-client-project"
  org_id     = "160037278965"

  billing_account = "01A2F5-73127B-50AE5B"

  depends_on = [
    google_project.for_service_account
  ]
}


resource "google_project_service" "apis_attestor" {
  project = google_project.attestor.project_id
  for_each = toset(
    [
      "binaryauthorization.googleapis.com",
      "containeranalysis.googleapis.com",
      "cloudkms.googleapis.com",
    ]
  )
  service = each.key
}


resource "google_project" "attestation" {
  name       = "Attestation Project"
  project_id = "binauthz-attestions-tst-prj"
  org_id     = "160037278965"

  billing_account = "01A2F5-73127B-50AE5B"

  depends_on = [
    google_project.for_service_account
  ]
}

resource "google_project_service" "apis_attestation" {
  project = google_project.attestor.project_id
  for_each = toset(
    [
      "binaryauthorization.googleapis.com",
      "containeranalysis.googleapis.com",
      "serviceusage.googleapis.com",
      "cloudkms.googleapis.com",
    ]
  )
  service = each.key
}

resource "google_project_service" "apis_client" {
  project = google_project.binauthz_client.project_id
  for_each = toset(
    [
      "binaryauthorization.googleapis.com",
      "containeranalysis.googleapis.com",
    ]
  )
  service = each.key
}