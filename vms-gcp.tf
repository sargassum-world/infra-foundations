provider "google" {
  project = "sargassum-world"
  region  = "us-west1"
  zone    = "us-west1-a"
}

resource "google_compute_network" "foundations" {
  name = "foundations"
}

resource "google_compute_subnetwork" "foundations-us-west1" {
  name          = "foundations-us-west1"
  network       = google_compute_network.foundations.id
  region        = "us-west1"
  ip_cidr_range = "10.128.0.0/24"
}

resource "google_kms_key_ring" "disks-1" {
  name     = "foundations-disks-1"
  location = "global"
}

// Note: the service account can't just give whatever permissions it wants, so this step actually
// has to be performed manually in the Google Cloud console. Just go to the Key Management panel,
// open the Info Panel on the right, select the keyring, and click "Add Principal" to grant the
// "Cloud KMS CryptoKey Encrypter/Decrypter" role to the Google Compute Engine Service Agent's
// service account, which has the format
// service-PROJECT_NUMBER@compute-system.iam.gserviceaccount.com (note: this is not the Terraform
// service account, nor is it the Compute Engine default service account, which has the format
// PROJECT_NUMBER-compute@developer.gserviceaccount.com!).
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

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_instance" "us-west1-a-1" {
  name         = "foundations-us-west1-a-1"
  region       = "us-west1"
  zone         = "us-west1-a"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
    }
    kms_key_self_link = google_kms_crypto_key.disk-1-1.id
  }

  network_interface {
    subnetwork = google_compute_subnetwork.foundations-us-west1.id
  }

  metadata = {
    block-project-ssh-keys = true
  }

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}

resource "google_compute_router" "us-west1" {
  name    = "foundations-us-west1"
  region  = "us-west1"
  network = google_compute_network.foundations.id
  
  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "us-west1" {
  name                               = "foundations-us-west1"
  router                             = google_compute_router.us-west1.name
  region                             = "us-west1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  
  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
