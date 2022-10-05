# Global Network

resource "google_compute_network" "foundations" {
  name = "foundations"
}

resource "google_compute_firewall" "allow_iap_forwarded_ssh" {
  name    = "allow-iap-forwarded-ssh"
  network = google_compute_network.foundations.name

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-ssh"]
}

# TODO: is this needed? defsec warns against allowing ingress traffic from /0 on the public internet
/*
resource "google_compute_firewall" "allow_zerotier_udp" {
  name    = "allow-zerotier"
  network = google_compute_network.foundations.name

  allow {
    protocol = "udp"
    ports    = ["9993"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["zerotier-agent"]
}
*/

resource "google_compute_firewall" "allow_nomad_http" {
  name    = "allow-nomad-http"
  network = google_compute_network.foundations.name

  allow {
    protocol = "tcp"
    ports    = ["4646"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nomad-api"]
}

# We don't need to connect to clients over the public internet yet
/*
resource "google_compute_firewall" "allow_nomad_rpc" {
  name    = "allow-nomad-rpc"
  network = google_compute_network.foundations.name

  allow {
    protocol = "tcp"
    ports    = ["4647"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nomad-server", "nomad-client"]
}
*/

# We don't need Nomad server clustering yet
/*
resource "google_compute_firewall" "allow_nomad_serf_tcp" {
  name    = "allow-nomad-serf-tcp"
  network = google_compute_network.foundations.name

  allow {
    protocol = "tcp"
    ports    = ["4648"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nomad-server"]
}

resource "google_compute_firewall" "allow_nomad_serf_udp" {
  name    = "allow-nomad-serf-udp"
  network = google_compute_network.foundations.name

  allow {
    protocol = "udp"
    ports    = ["4648"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nomad-server"]
}
*/

# Note: the service account can't just give itself whatever permissions it wants, so this step
# actually has to be performed manually in the Google Cloud console. Just go to the Identity-Aware
# Proxy panel, enable the Identity-Aware Proxy API (if needed), select the SSH and TCP Resources
# tab, check the checkbox for "All Tunnel Resources", click "Add Principal" in the right pane, and
# add the GCP service account for Terraform to the "New principals" field and the IAP-secured Tunnel
# User role to the Roles dropdown.
/*resource "google_project_iam_member" "iap_terraform" {
  project = var.gcp_project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = var.gcp_terraform_service_account
}*/

# us-west1 Region

resource "google_compute_subnetwork" "foundations_us_west1" {
  name          = "foundations-us-west1"
  network       = google_compute_network.foundations.id
  region        = "us-west1"
  ip_cidr_range = "10.64.0.0/24"

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_router" "us_west1" {
  name    = "foundations-us-west1"
  region  = "us-west1"
  network = google_compute_network.foundations.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "us_west1" {
  name                               = "foundations-us-west1"
  router                             = google_compute_router.us_west1.name
  region                             = "us-west1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

# External IP Addresses

resource "google_compute_address" "us_west1_a_1" {
  name         = "foundations-us-west1-a-1"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
}
