variable "name" {
  type        = string
  description = "Name of resources for the region"
}

variable "gcp_network_id" {
  type        = string
  description = "ID of the VPC network"
}

variable "gcp_region" {
  type        = string
  description = "Region of resources for the VPC subnetwork"
}

variable "ipv4_cidr" {
  type        = string
  description = "CIDR range of IPv4 addresses to reserve for the VPC subnetwork"
}
