#######################################
## Certificate Authority
#######################################
resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  allowed_uses = ["crl_signing", "cert_signing"]
  key_algorithm = "RSA"
  private_key_pem = tls_private_key.ca.private_key_pem
  validity_period_hours = var.validity_period_hours
  is_ca_certificate = true
  subject {
    common_name = "${var.prefix}.vpn.ca"
    organization = var.organization
  }
}

resource "aws_acm_certificate" "ca" {
}
