provider "google" {
  project = "sargassum-world"
  region  = "us-west1"
  zone    = "us-west1-a"
}

resource "google_kms_key_ring" "disks-1" {
  name     = "foundations-disks-1"
  location = "global"
}

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

// Note: the service account obviously can't just give itself whatever permissions it wants, so this
// step actually has to be performed manually in the Google Cloud console. Just go to the Key
// Management panel, navigate to and select the key, open the Info Panel on the right, and click
// "Add Principal" to grant the "Cloud KMS CryptoKey Encrypter/Decrypter" role to the Terraform
// service account.
/*
resource "google_kms_crypto_key_iam_member" "disks-1-service-tf" {
  crypto_key_id = google_kms_crypto_key.disk-1-1.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${var.gcp_service_account}"
}
*/

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
