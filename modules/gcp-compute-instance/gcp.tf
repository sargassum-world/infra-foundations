resource "google_compute_address" "instance" {
  name         = var.name
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}

resource "google_compute_instance" "instance" {
  name         = var.name
  zone         = var.gcp_zone
  machine_type = var.gcp_machine_type

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.gcp_boot_disk_image
    }
    kms_key_self_link = var.gcp_boot_disk_kms_key_id
  }

  attached_disk {
    source            = var.gcp_data_disk_id
    device_name       = "data"
    kms_key_self_link = var.gcp_data_disk_kms_key_id
  }

  network_interface {
    subnetwork = var.gcp_vpc_subnet_id

    access_config {
      nat_ip       = google_compute_address.instance.address
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    block-project-ssh-keys = true
  }

  tags = var.gcp_tags

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}