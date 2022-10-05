terraform {
  cloud {
    organization = "sargassum-world"

    workspaces {
      name = "infra-foundations-prod"
    }
  }

  required_providers {
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.2.0"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
    /*hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.35.2"
    }*/
    google = {
      source  = "hashicorp/google"
      version = "~> 4.38.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "~> 1.4.18"
    }
  }
}
