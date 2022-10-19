terraform {
  required_providers {
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
  }
}
