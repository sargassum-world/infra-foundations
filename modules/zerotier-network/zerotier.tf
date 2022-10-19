resource "zerotier_network" "network" {
  name        = "${var.name_subname}.${var.name_parent_domain}"
  description = var.zerotier_description

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
  flow_rules       = var.zerotier_flow_rules
}
