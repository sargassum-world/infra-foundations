# Keys

# Note: depends on google_project_service.cloudkms
resource "google_kms_key_ring" "disks_1" {
  name     = "foundations-disks-1"
  location = "global"
}

# Note: the Terraform service account must be given the Cloud KMS Admin role or another role with
# the cloudkms.keyRings.setIamPolicy permission, such as the Security Admin role, so that it can
# manage the roles for GCP's own service accounts. You can manually do this from the IAM & Admin
# console.
resource "google_kms_key_ring_iam_member" "disks_1_service_tf" {
  key_ring_id = google_kms_key_ring.disks_1.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "serviceAccount:service-${google_project.foundations.number}@compute-system.iam.gserviceaccount.com"
}

resource "google_kms_crypto_key" "disk_1_1" {
  name            = "foundations-disk-1-1"
  key_ring        = google_kms_key_ring.disks_1.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7770000s"

  lifecycle {
    prevent_destroy = true
  }
}

# Virtual Machines

# Note: depends on google_project_service.compute
resource "google_compute_instance" "us_west1_a_1" {
  name         = "foundations-us-west1-a-1"
  zone         = "us-west1-a"
  machine_type = "e2-micro"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.gcp_vm_orchestrator_image
    }
    kms_key_self_link = google_kms_crypto_key.disk_1_1.id
  }

  network_interface {
    subnetwork = google_compute_subnetwork.foundations_us_west1.id

    access_config {
      nat_ip       = google_compute_address.us_west1_a_1.address
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    block-project-ssh-keys = true
  }

  tags = ["iap-ssh", "zerotier-agent", "nomad-api", "nomad-server", "nomad-client"]

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}
