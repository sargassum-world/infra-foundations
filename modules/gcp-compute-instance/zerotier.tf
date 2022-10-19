resource "zerotier_identity" "instance" {}

resource "zerotier_member" "instance" {
  name           = var.name
  member_id      = zerotier_identity.instance.id
  network_id     = var.zerotier_network_id
  ip_assignments = [var.zerotier_ipv4]
}
