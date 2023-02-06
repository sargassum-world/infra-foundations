terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.51.0"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.3.0"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "~> 1.4.19"
    }
  }
}
