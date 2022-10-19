# DNS records for public IP address

locals {
  subname_device = "${var.name}.d"
}

resource "desec_rrset" "device_a" {
  domain  = var.dns_infra_domain_name
  subname = local.subname_device
  type    = "A"
  records = [google_compute_address.instance.address]
  ttl     = 3600
}

resource "desec_rrset" "device_services_wildcard_a" {
  domain  = var.dns_infra_domain_name
  subname = "*.s.${local.subname_device}"
  type    = "A"
  records = [google_compute_address.instance.address]
  ttl     = 3600
}

# DNS records for ZeroTier network membership

locals {
  subname_zerotier_device = "${var.name}.d.${var.dns_zerotier_network_subname}"
  zerotier_ipv6_rfc4193 = join(":", [
    for chunk in chunklist(split(
      "",
      "fd${var.zerotier_network_id}9993${zerotier_identity.instance.id}"
    ), 4) :
    join("", chunk)
  ])
}

resource "desec_rrset" "zerotier_device_a" {
  domain  = var.dns_infra_domain_name
  subname = local.subname_zerotier_device
  type    = "A"
  records = zerotier_member.instance.ip_assignments
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_aaaa" {
  domain  = var.dns_infra_domain_name
  subname = local.subname_zerotier_device
  type    = "AAAA"
  records = [local.zerotier_ipv6_rfc4193]
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_services_wildcard_a" {
  domain  = var.dns_infra_domain_name
  subname = "*.s.${local.subname_zerotier_device}"
  type    = "A"
  records = zerotier_member.instance.ip_assignments
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_services_wildcard_aaaa" {
  domain  = var.dns_infra_domain_name
  subname = "*.s.${local.subname_zerotier_device}"
  type    = "AAAA"
  records = [local.zerotier_ipv6_rfc4193]
  ttl     = 3600
}
