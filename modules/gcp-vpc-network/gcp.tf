resource "google_compute_network" "network" {
  name                    = var.name
  auto_create_subnetworks = false
}

# Firewall

resource "google_compute_firewall" "allow_iap_forwarded_ssh" {
  name    = "allow-iap-forwarded-ssh"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap-ssh"]
}

resource "google_compute_firewall" "allow_zerotier_udp" {
  name    = "allow-zerotier"
  network = google_compute_network.network.name

  allow {
    protocol = "udp"
    ports    = ["9993"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["zerotier-agent"]
}

resource "google_compute_firewall" "allow_nomad_http" {
  name    = "allow-nomad-http"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["4646"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nomad-api"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "allow_http3" {
  name    = "allow-http-3"
  network = google_compute_network.network.name

  allow {
    protocol = "udp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http3-server"]
}
