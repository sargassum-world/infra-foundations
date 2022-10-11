# Keys

# Note: depends on google_project_service.iam
data "google_storage_project_service_account" "default" {
}

# Note: depends on google_project_service.cloudkms
resource "google_kms_key_ring" "buckets_1" {
  name     = "foundations-buckets-1"
  location = "global"
}

# Note: the Terraform service account must be given the Cloud KMS Admin role or another role with
# the cloudkms.keyRings.setIamPolicy permission, such as the Security Admin role, so that it can
# manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_kms_key_ring_iam_member" "buckets_1_service_tf" {
  key_ring_id = google_kms_key_ring.buckets_1.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "serviceAccount:${data.google_storage_project_service_account.default.email_address}"
}

resource "google_kms_crypto_key" "bucket_1_1" {
  name            = "foundations-bucket-1-1"
  key_ring        = google_kms_key_ring.buckets_1.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7770000s"

  lifecycle {
    prevent_destroy = true
  }
}

# Buckets

resource "google_storage_bucket" "foundations_caddy_public_server_data" {
  name                        = "foundations-us-west1-a-1-caddy-public-data"
  location                    = "US-WEST1"
  force_destroy               = true
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true

  encryption {
    default_kms_key_name = google_kms_crypto_key.bucket_1_1.id
  }
}
