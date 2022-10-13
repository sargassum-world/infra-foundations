resource "tls_private_key" "dns_acme" {
  algorithm = "RSA"
}

resource "acme_registration" "dns" {
  account_key_pem = tls_private_key.dns_acme.private_key_pem
  email_address   = var.acme_email
}

