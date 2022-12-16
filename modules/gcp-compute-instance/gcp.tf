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

  # FIXME: this leaks the private key through metadata, thus exposing it through Nomad's web UI
  # which displays client info. To prevent this, remove any permissions for the instance to query
  # metadata fields. Note that this also disables use of the VM instance's default service account;
  # and it's unclear whether removing access would also prevent the startup script from being run.
  # Another option could be to make the startup script delete secrets from metadata, though
  # Terraform will restore them on the next apply (which will make Terraform diffs annoying).
  # For now we will live with this security vulnerability.
  metadata_startup_script = templatefile("${path.module}/startup-script.sh.tftpl", {
    zerotier_private_key = zerotier_identity.instance.private_key
    zerotier_public_key  = zerotier_identity.instance.public_key
    zerotier_network_id  = var.zerotier_network_id
  })

  tags = var.gcp_tags

  shielded_instance_config {
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }
}
