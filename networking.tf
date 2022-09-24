provider "zerotier" {}

resource "zerotier_network" "foundations" {
  name        = "foundations.infra.sargassum.world"
  description = "Control plane for the foundations of sargassum.world"

  assign_ipv4 {
    zerotier = false
  }

  assign_ipv6 {
    zerotier = false
    sixplane = true
    rfc4193  = false
  }

  private          = true
  enable_broadcast = true
  flow_rules       = file("${path.module}/ztoverlay-flowrules.txt")
}
