# Global Network

resource "google_compute_network" "foundations" {
  name = "foundations"
}

resource "google_compute_firewall" "allow-iap-forwarded-ssh" {
  name    = "allow-iap-forwarded-ssh"
  network = google_compute_network.foundations.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-ssh"]
}

resource "google_compute_firewall" "allow-zerotier-ingress" {
  name    = "allow-zerotier-ingress"
  network = google_compute_network.foundations.name

  allow {
    protocol = "udp"
    ports    = ["9993"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["zerotier"]
}

resource "google_compute_firewall" "allow-zerotier-egress" {
  name      = "allow-zerotier-egress"
  network   = google_compute_network.foundations.name
  direction = "EGRESS"

  allow {
    protocol = "udp"
  }

  target_tags = ["zerotier"]
}

# Note: the service account can't just give itself whatever permissions it wants, so this step
# actually has to be performed manually in the Google Cloud console. Just go to the Identity-Aware
# Proxy panel, enable the Identity-Aware Proxy API (if needed), select the SSH and TCP Resources
# tab, check the checkbox for "All Tunnel Resources", click "Add Principal" in the right pane, and
# add the GCP service account for Terraform to the "New principals" field and the IAP-secured Tunnel
# User role to the Roles dropdown.
/*resource "google_project_iam_member" "iap-terraform" {
  project = var.gcp-project-id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = var.gcp-terraform-service-account
}*/

# us-west1 Region

resource "google_compute_subnetwork" "foundations-us-west1" {
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
