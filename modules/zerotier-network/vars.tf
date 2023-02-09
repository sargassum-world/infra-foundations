variable "name_subname" {
  type        = string
  description = "Subdomain name of the ZeroTier network name"
}

variable "name_parent_domain" {
  type        = string
  description = "Parent domain name of the ZeroTier network name"
}

variable "zerotier_description" {
  type        = string
  description = "Description of the ZeroTier network"
}

variable "zerotier_ipv6_sixplane" {
  type        = bool
  description = "Whether 6PLANE IPv6 addresses are auto-assigned in the ZeroTier network"
  default     = true
}

variable "zerotier_ipv6_rfc4193" {
  type        = bool
  description = "Whether RFC4193 IPv6 addresses are auto-assigned in the ZeroTier network"
  default     = false
}

variable "zerotier_flow_rules" {
  type        = string
  description = "ZeroTier network flow rules"
}

variable "zerotier_routed_ipv4_cidr" {
  type        = string
  description = "CIDR range of IPv4 addresses to route to devices in the ZeroTier network"
}

variable "service_reverse_proxies_ipv4" {
  type        = list(string)
  description = "IPv4 addresses in the ZeroTier network of servers acting as reverse proxies for services"
}

variable "service_reverse_proxies_ipv6" {
  type        = list(string)
  description = "IPv6 addresses in the ZeroTier network of servers acting as reverse proxies for services"
}

variable "service_device_subnames" {
  type        = list(string)
  description = "DNS subnames of devices in the ZeroTier network hosting services, under name_parent_domain"
}

variable "acme_account_key" {
  type        = string
  description = "Account key PEM for provisioning ACME certificates"
}

variable "acme_desec_api_token" {
  type        = string
  description = "API token for deSEC to solve ACME challenges"
  sensitive   = true
}
