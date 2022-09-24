provider "google" {
  project = "sargassum-world"
  region  = "us-west1"
  zone    = "us-west1-a"
}

resource "google_kms_key_ring" "disks-1" {
  name     = "foundations-disks-1"
  location = "global"
}

// Note: the service account can't just give whatever permissions it wants, so this step actually
// has to be performed manually in the Google Cloud console. Just go to the Key Management panel,
// open the Info Panel on the right, select the keyring, and click "Add Principal" to grant the
// "Cloud KMS CryptoKey Encrypter/Decrypter" role to the Google Compute Engine service account
// (note: this is not the Terraform service account!).
/*
resource "google_kms_key_ring_iam_member" "disks-1-service-tf" {
  key_ring_id = google_kms_key_ring.disks-1.id
  role        = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member      = "serviceAccount:${var.gce_service_account}"
}
*/

resource "google_kms_crypto_key" "disk-1-1" {
  name            = "foundations-disk-1-1"
  key_ring        = google_kms_key_ring.disks-1.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "7770000s"

  // TODO: restore this lifecycle hook!
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_instance" "us-west1-a-1" {
  name         = "foundations-us-west1-a-1"
  machine_type = "e2-micro"
  zone         = "us-west1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
    }
    kms_key_self_link = google_kms_crypto_key.disk-1-1.id
  }

  network_interface {
    network = "default"
  }

  metadata = {
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}
