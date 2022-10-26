terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.41.0"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.2.0"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
  }
}
