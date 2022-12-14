# Main Project

resource "google_service_account" "packer" {
  account_id   = "infra-packer"
  display_name = "infra-packer"
  description  = "Build VM images"
}

# Note: the Terraform service account must be given the Project IAM Admin role or another role with
# the resourcemanager.projects.setIamPolicy permission, such as the Security Admin role, so that it
# can manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_project_iam_member" "compute_service_pkr" {
  project = google_project.foundations.project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.packer.email}"
}

# Note: the Terraform service account must be given the Project IAM Admin role or another role with
# the resourcemanager.projects.setIamPolicy permission, such as the Security Admin role, so that it
# can manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_project_iam_member" "iap_service_pkr" {
  project = google_project.foundations.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${google_service_account.packer.email}"
}

# Planktoscope Project

resource "google_service_account" "packer_planktoscope" {
  provider     = google.planktoscope
  account_id   = "infra-packer"
  display_name = "infra-packer"
  description  = "Build VM images"
}

# Note: the Terraform service account must be given the Project IAM Admin role or another role with
# the resourcemanager.projects.setIamPolicy permission, such as the Security Admin role, so that it
# can manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_project_iam_member" "compute_service_pkr_planktoscope" {
  provider = google.planktoscope
  project  = google_project.foundations_planktoscope.project_id
  role     = "roles/compute.instanceAdmin.v1"
  member   = "serviceAccount:${google_service_account.packer_planktoscope.email}"
}

# Note: the Terraform service account must be given the Project IAM Admin role or another role with
# the resourcemanager.projects.setIamPolicy permission, such as the Security Admin role, so that it
# can manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_project_iam_member" "iap_service_pkr_planktoscope" {
  provider = google.planktoscope
  project  = google_project.foundations_planktoscope.project_id
  role     = "roles/iap.tunnelResourceAccessor"
  member   = "serviceAccount:${google_service_account.packer_planktoscope.email}"
}
