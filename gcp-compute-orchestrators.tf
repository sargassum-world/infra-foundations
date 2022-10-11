# IP Addresses

resource "google_compute_address" "us_west1_a_1" {
  name         = "foundations-us-west1-a-1"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}

# VMs

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
    kms_key_self_link = google_kms_crypto_key.disk_global_1_1.id
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

  tags = ["iap-ssh", "zerotier-agent", "nomad-api", "nomad-server", "nomad-client", "http-server"]

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}
