output "name_subname" {
  description = "Subdomain name of the ZeroTier network name"
  value       = var.name_subname
}

output "name_parent_domain" {
  description = "Parent domain name of the ZeroTier network name"
  value       = var.name_parent_domain
}

output "zerotier_network_id" {
  description = "ID of the ZeroTier network"
  value       = zerotier_network.network.id
}

output "zerotier_ipv6_sixplane" {
  description = "Whether 6PLANE IPv6 addresses will be auto-assigned"
  value       = var.zerotier_ipv6_sixplane
}

output "zerotier_ipv6_rfc4193" {
  description = "Whether RFC4193 IPv6 addresses will be auto-assigned"
  value       = var.zerotier_ipv6_rfc4193
}

output "acme_certificate" {
  description = "Full chain certificate in PEM format for HTTPS on domain names in the ZeroTier network"
  value       = "${acme_certificate.wildcards.certificate_pem}${acme_certificate.wildcards.issuer_pem}"
}

output "acme_private_key" {
  description = "Private key in PEM format for HTTPS on domain names in the ZeroTier network"
  value       = acme_certificate.wildcards.private_key_pem
}
