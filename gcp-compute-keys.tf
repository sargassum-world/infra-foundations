# Keys

# Note: depends on google_project_service.cloudkms
resource "google_kms_key_ring" "disks_global_1" {
  name     = "foundations-disks-1"
  location = "global"
}

# Note: the Terraform service account must be given the Cloud KMS Admin role or another role with
# the cloudkms.keyRings.setIamPolicy permission, such as the Security Admin role, so that it can
# manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_kms_key_ring_iam_member" "disks_global_1_service_tf" {
  key_ring_id = google_kms_key_ring.disks_global_1.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "serviceAccount:service-${google_project.foundations.number}@compute-system.iam.gserviceaccount.com"
}

resource "google_kms_crypto_key" "disk_global_1_1" {
  name            = "foundations-disk-1-1"
  key_ring        = google_kms_key_ring.disks_global_1.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7770000s"

  lifecycle {
    prevent_destroy = true
  }
}
