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
      version = "~> 2.3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.4.0"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.12.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.52.0"
    }
  }
}
