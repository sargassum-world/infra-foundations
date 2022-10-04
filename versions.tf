terraform {
  cloud {
    organization = "sargassum-world"

    workspaces {
      name = "infra-foundations-prod"
    }
  }

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.37.0"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.2.0"
    }
    /*hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~>1.35.2"
    }*/
    google = {
      source  = "hashicorp/google"
      version = "~>4.38.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "~>1.4.18"
    }
  }
}
