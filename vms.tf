/*provider "hcloud" {
}*/

provider "google" {
  project = "sargassum-world"
  region  = "us-west1"
  zone    = "us-west1-a"
}

/*resource "hcloud_server" "eu-central-fsn1-dc14-1" {
  name        = "foundations-eu-central-fsn1-dc14-1"
  server_type = "cpx11"
  image       = "alpine-virt-3.16.0"
  location    = "fsn1"
  datacenter  = "dc14"
}*/

resource "google_kms_key_ring" "foundations-1" {
  name     = "foundations-1"
  location = "global"
}

resource "google_kms_crypto_key" "foundations-1-1" {
  name            = "foundations-1"
  key_ring        = google_kms_key_ring.foundations-1
  rotation_period = "7777000s"

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
    disk_encryption_key_raw = google_kms_crypto_key.foundations-1-1
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
