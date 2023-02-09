resource "zerotier_network" "network" {
  name        = "${var.name_subname}.${var.name_parent_domain}"
  description = var.zerotier_description

  assign_ipv4 {
    zerotier = false
  }

  assign_ipv6 {
    zerotier = false
    sixplane = var.zerotier_ipv6_sixplane
    rfc4193  = var.zerotier_ipv6_rfc4193
  }

  private          = true
  enable_broadcast = true
  flow_rules       = var.zerotier_flow_rules
}
