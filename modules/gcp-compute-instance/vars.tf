variable "name" {
  type        = string
  description = "Name of the instance"
}

variable "zerotier_network_id" {
  type        = string
  description = "Network ID of ZeroTier network to add the instance to"
}

variable "zerotier_ipv4" {
  type        = string
  description = "IPv4 address to assign to the instance in the ZeroTier network"
}

variable "dns_domain_name" {
  type        = string
  description = "Parent DNS domain name for RRsets"
}

variable "dns_zerotier_network_subname" {
  type        = string
  description = "DNS subname for the ZeroTier network"
}
