# Service Account
#
resource "google_service_account" "nomad_plugin_csi_gcs" {
  account_id   = "nomad-plugin-csi-gcs"
  display_name = "nomad-plugin-csi-gcs"
  description  = "Manage GCS buckets for Nomad workload volumes"
}

# Note: the Terraform service account must be given the Project IAM Admin role or another role with
# the resourcemanager.projects.setIamPolicy permission, such as the Security Admin role, so that it
# can manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_project_iam_member" "storage_service_nomad_plugin_csi" {
  project = google_project.foundations.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.nomad_plugin_csi_gcs.email}"
}

# Volumes

resource "google_storage_bucket" "foundations_caddy_public_server_data" {
  name                        = "foundations-us-west1-a-1-caddy-public-data"
  location                    = "US-WEST1"
  force_destroy               = true
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_us_west1_1_1.id
  }
}
