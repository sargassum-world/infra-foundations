data "google_storage_project_service_account" "default" {
  depends_on = [
    google_project_service.iam
  ]
}

resource "google_kms_key_ring" "buckets_global_1" {
  name     = "foundations-buckets-1"
  location = "global"

  depends_on = [
    google_project_service.cloudkms
  ]
}

# Note: the Terraform service account must be given the Cloud KMS Admin role or another role with
# the cloudkms.keyRings.setIamPolicy permission, such as the Security Admin role, so that it can
# manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_kms_key_ring_iam_member" "buckets_global_1_service_tf" {
  key_ring_id = google_kms_key_ring.buckets_global_1.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "serviceAccount:${data.google_storage_project_service_account.default.email_address}"
}

resource "google_kms_crypto_key" "bucket_global_1_1" {
  name            = "foundations-bucket-1-1"
  key_ring        = google_kms_key_ring.buckets_global_1.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7770000s"

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_key_ring" "buckets_us_west1_1" {
  name     = "foundations-buckets-us-west1-1"
  location = "us-west1"

  depends_on = [
    google_project_service.cloudkms
  ]
}

# Note: the Terraform service account must be given the Cloud KMS Admin role or another role with
# the cloudkms.keyRings.setIamPolicy permission, such as the Security Admin role, so that it can
# manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_kms_key_ring_iam_member" "buckets_us_west1_1_service_tf" {
  key_ring_id = google_kms_key_ring.buckets_us_west1_1.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "serviceAccount:${data.google_storage_project_service_account.default.email_address}"
}

resource "google_kms_crypto_key" "bucket_us_west1_1_1" {
  name            = "foundations-bucket-us_west1-1-1"
  key_ring        = google_kms_key_ring.buckets_us_west1_1.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7770000s"

  lifecycle {
    prevent_destroy = true
  }
}
