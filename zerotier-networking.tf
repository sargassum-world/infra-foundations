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
    target = "10.144.64.0/24"
  }
}

# Administrative devices

# TODO: specify administrative members through a Terraform variable
resource "zerotier_member" "ethan_vulcan" {
  name       = "ethan-vulcan"
  member_id  = "cb1b5001de"
  network_id = zerotier_network.foundations.id
}
