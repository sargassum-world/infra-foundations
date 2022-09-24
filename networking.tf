provider "zerotier" {}

resource "zerotier_network" "bootstrap" {
  name        = "bootstrap.infra.sargassum.world"
  description = "Control plane for bootstrapping sargassum.world"

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
