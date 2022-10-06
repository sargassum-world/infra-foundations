resource "zerotier_network" "foundations" {
  name        = "foundations.infra.sargassum.world"
  description = "Control plane for the foundations of sargassum.world"

  assign_ipv4 {
    zerotier = false
  }

  assign_ipv6 {
    zerotier = false
    sixplane = true
    rfc4193  = true
  }

  private          = true
  enable_broadcast = true
  flow_rules       = file("${path.module}/zerotier-networking-foundations.flowrules")

  route {
    target = "10.144.0.0/24"
  }
}

# Virtual Machines

resource "zerotier_identity" "gcp_us_west1_a_1" {}

resource "zerotier_member" "gcp_us_west1_a_1" {
  name           = "gcp-us-west1-a-1"
  member_id      = zerotier_identity.gcp_us_west1_a_1.id
  network_id     = zerotier_network.foundations.id
  ip_assignments = ["10.144.0.1"]
}

# Administrative devices

# TODO: specify administrative members through a Terraform variable
resource "zerotier_member" "ethan_vulcan" {
  name       = "ethan-vulcan"
  member_id  = "cb1b5001de"
  network_id = zerotier_network.foundations.id
}
