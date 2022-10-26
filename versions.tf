terraform {
  cloud {
    organization = "sargassum-world"

    workspaces {
      name = "infra-foundations-prod"
    }
  }

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.2.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.3"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.2.0"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.11.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.41.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "~> 1.4.18"
    }
  }
}
