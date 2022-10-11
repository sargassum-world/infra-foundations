resource "google_service_account" "packer" {
  account_id   = "infra-packer"
  display_name = "infra-packer"
  description  = "Build VM images"
}

resource "google_project_iam_member" "compute_service_pkr" {
  project = google_project.foundations.project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.packer.email}"
}

resource "google_project_iam_member" "iap_service_pkr" {
  project = google_project.foundations.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${google_service_account.packer.email}"
}
