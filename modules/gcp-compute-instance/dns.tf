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
  zerotier_ipv6_all = setunion(
    zerotier_member.instance.ipv6_assignments,
    # FIXME: for some reason, we can't seem to remove RFC4193 addresses from DNS records
    # var.zerotier_ipv6_rfc4193 ? [zerotier_member.instance.rfc4193] : [],
    [zerotier_member.instance.rfc4193],
    var.zerotier_ipv6_sixplane ? [zerotier_member.instance.sixplane] : []
  )
}

resource "desec_rrset" "zerotier_device_a" {
  domain  = var.dns_infra_domain_name
  subname = local.subname_zerotier_device
  type    = "A"
  records = zerotier_member.instance.ipv4_assignments
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_aaaa" {
  domain  = var.dns_infra_domain_name
  subname = local.subname_zerotier_device
  type    = "AAAA"
  records = local.zerotier_ipv6_all
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_services_wildcard_a" {
  domain  = var.dns_infra_domain_name
  subname = "*.s.${local.subname_zerotier_device}"
  type    = "A"
  records = zerotier_member.instance.ipv4_assignments
  ttl     = 3600
}

resource "desec_rrset" "zerotier_device_services_wildcard_aaaa" {
  domain  = var.dns_infra_domain_name
  subname = "*.s.${local.subname_zerotier_device}"
  type    = "AAAA"
  records = local.zerotier_ipv6_all
  ttl     = 3600
}
