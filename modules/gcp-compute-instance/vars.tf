variable "name" {
  type        = string
  description = "Name of the instance"
}

variable "gcp_zone" {
  type        = string
  description = "Zone in which to deploy the instance"
}

variable "gcp_machine_type" {
  type        = string
  description = "Machine type of the instance"
}

variable "gcp_tags" {
  type        = list(string)
  description = "Tags to attach to the instance"
}

variable "gcp_boot_disk_image" {
  type        = string
  description = "Name of the OS image for making the boot disk of the instance"
}

variable "gcp_boot_disk_kms_key_id" {
  type        = string
  description = "Self-link ID of the KMS key for encrypting the boot disk of the instance"
}

variable "gcp_data_disk_id" {
  type        = string
  description = "ID of the persistent data disk to attach to the instance"
}

variable "gcp_data_disk_kms_key_id" {
  type        = string
  description = "Self-link ID of the KMS key for encrypting the persistent data disk attached to the instance"
}

variable "gcp_vpc_subnet_id" {
  type        = string
  description = "ID of the VPC subnet for the instance"
}

variable "zerotier_network_id" {
  type        = string
  description = "Network ID of ZeroTier network to add the instance to"
}

variable "zerotier_ipv4" {
  type        = string
  description = "IPv4 address to assign to the instance in the ZeroTier network"
}

variable "dns_root_domain_name" {
  type        = string
  description = "Parent DNS domain name for root-level services"
}

variable "dns_infra_domain_name" {
  type        = string
  description = "Parent DNS domain name for infrastructure-related RRsets"
}

variable "dns_zerotier_network_subname" {
  type        = string
  description = "DNS subname for the ZeroTier network, under dns_infra_domain_name"
}

variable "acme_email" {
  type        = string
  description = "Contact email address for ACME registration"
}

variable "acme_ztoverlay_certificate" {
  type        = string
  description = "Full chain certificate in PEM format for HTTPS on domain names in the ZeroTier network"
}

variable "acme_ztoverlay_private_key" {
  type        = string
  description = "Private key in PEM format for HTTPS on domain names in the ZeroTier network"
}

variable "nomad_datacenter" {
  type        = string
  description = "Name of the Nomad datacenter to run instance-specific jobs"
}
