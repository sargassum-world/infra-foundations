terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.53.1"
    }
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.4.0"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
  }
}
