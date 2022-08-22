resource "google_project" "attestor" {
  name       = "Attestor Project"
  project_id = "binauthz-attestor-test-project"
  org_id     = "160037278965"
}

resource "google_project" "attestation" {
  name       = "Attestation Project"
  project_id = "binauthz-attestions-tst-prj"
  org_id     = "160037278965"
}