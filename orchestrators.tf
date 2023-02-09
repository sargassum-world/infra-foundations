# us_west1_a_1

resource "google_compute_disk" "us_west1_a_1_data" {
  name = "foundations-us-west1-a-1-data"
  type = "pd-standard"
  zone = "us-west1-a"
  size = 10

  disk_encryption_key {
    kms_key_self_link = google_kms_crypto_key.disk_global_1_1.id
  }

  lifecycle {
    prevent_destroy = true
  }

  # After creation, this disk needs to be manually formatted following the instructions at
  # https://cloud.google.com/compute/docs/disks/add-persistent-disk#formatting
}

module "orchestrator_gcp_us_west1_a_1" {
  source = "./modules/gcp-compute-instance"

  name = "gcp-us-west1-a-1"

  gcp_zone         = "us-west1-a"
  gcp_machine_type = "e2-micro"
  gcp_tags = [
    "iap-ssh", "zerotier-agent", "nomad-api", "nomad-server", "nomad-client", "http-server",
    "http3-server",
  ]
  gcp_boot_disk_image      = var.gcp_vm_orchestrator_image
  gcp_boot_disk_kms_key_id = google_kms_crypto_key.disk_global_1_1.id
  gcp_data_disk_id         = google_compute_disk.us_west1_a_1_data.id
  gcp_data_disk_kms_key_id = google_compute_disk.us_west1_a_1_data.disk_encryption_key[0].kms_key_self_link
  gcp_vpc_subnet_id        = module.vpc_subnetwork_gcp_us_west1.gcp_subnetwork_id

  zerotier_network_id    = module.zerotier_network_foundations.zerotier_network_id
  zerotier_ipv4          = "10.144.64.1"
  zerotier_ipv6_sixplane = module.zerotier_network_foundations.zerotier_ipv6_sixplane
  zerotier_ipv6_rfc4193  = module.zerotier_network_foundations.zerotier_ipv6_rfc4193

  dns_infra_domain_name        = desec_domain.infra.name
  dns_zerotier_network_subname = module.zerotier_network_foundations.name_subname

  depends_on = [
    google_project_service.compute,
    module.vpc_subnetwork_gcp_us_west1
  ]
}
