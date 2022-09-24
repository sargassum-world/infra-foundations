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
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
}*/

resource "google_compute_instance" "us-west1-a-1" {
  name         = "foundations-us-west1-a-1"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-minimal-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
