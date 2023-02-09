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
  # FIXME: The Terraform ZeroTier provider seems to have a bug where it flips the sixplane and
  # rfc4193 addresses! See https://github.com/zerotier/terraform-provider-zerotier/issues/36
  zerotier_ipv6_sixplane = replace(zerotier_member.instance.rfc4193, ":0000:0000:0001", "::1")
  zerotier_ipv6_rfc4193  = zerotier_member.instance.sixplane
  zerotier_ipv6_all = setunion(
    zerotier_member.instance.ipv6_assignments,
    var.zerotier_ipv6_sixplane ? [local.zerotier_ipv6_sixplane] : [],
    var.zerotier_ipv6_rfc4193 ? [local.zerotier_ipv6_rfc4193] : []
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
