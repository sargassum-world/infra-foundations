terraform {
  required_providers {
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
      version = "~> 2.13.0"
    }
  }
}
