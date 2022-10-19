output "zerotier_address" {
  description = "Address of the ZeroTier One agent assigned to the instance"
  value       = zerotier_identity.instance.id
}

output "zerotier_private_key" {
  description = "Private key of the ZeroTier One agent assigned to the instance"
  value       = zerotier_identity.instance.private_key
}

output "zerotier_public_key" {
  description = "Public key of the ZeroTier One agent assigned to the instance"
  value       = zerotier_identity.instance.public_key
}

output "zerotier_ipv4" {
  description = "IPv4 address assigned to the instance on the ZeroTier network"
  value       = var.zerotier_ipv4
}

output "zerotier_ipv6" {
  description = "RFC4193 NDP IPv6 address assigned to the instance on the ZeroTier network"
  value       = local.zerotier_ipv6_rfc4193
}

output "dns_zerotier_subname" {
  description = "DNS subname of the instance on the ZeroTier network"
  value       = local.subname_zerotier_device
}
