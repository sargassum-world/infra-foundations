terraform {
  required_providers {
    zerotier = {
      source  = "zerotier/zerotier"
      version = "~> 1.3.1"
    }
    desec = {
      source  = "Valodim/desec"
      version = "~> 0.3.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.11.1"
    }
  }
}
