resource "google_compute_subnetwork" "subnetwork" {
  name          = var.name
  network       = var.gcp_network_id
  region        = var.gcp_region
  ip_cidr_range = var.ipv4_cidr

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_router" "subnetwork" {
  name    = var.name
  region  = var.gcp_region
  network = var.gcp_network_id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "subnetwork" {
  name                               = var.name
  router                             = google_compute_router.subnetwork.name
  region                             = var.gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
