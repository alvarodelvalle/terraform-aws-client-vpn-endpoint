locals {
  algorithm = var.algorithm
  rsa_bits = upper(local.algorithm) == "RSA" ? var.rsa_bits : ""
  ecdsa_curve = upper(local.algorithm) == "ECDSA" ? var.ecdsa_curve : ""
}

#######################################
## Certificate Authority
#######################################
resource "tls_private_key" "ca" {
  algorithm = local.algorithm
  rsa_bits = local.rsa_bits
  ecdsa_curve = local.ecdsa_curve
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
  private_key = tls_private_key.ca.private_key_pem
  certificate_body = tls_self_signed_cert.ca.cert_pem
}

#######################################
## Root Certificate
#######################################
resource "tls_private_key" "root" {
  algorithm = "RSA"
}

resource "tls_cert_request" "root" {
  key_algorithm = "RSA"
  private_key_pem = tls_private_key.root.private_key_pem
  subject {
    common_name = "${var.prefix}.vpn.client"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "root" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  ca_cert_pem = tls_self_signed_cert.ca.cert_pem
  ca_key_algorithm = "RSA"
  ca_private_key_pem = tls_private_key.ca.private_key_pem
  cert_request_pem = tls_cert_request.root.cert_request_pem
  validity_period_hours = var.validity_period_hours
}

resource "aws_acm_certificate" "root" {
  private_key = tls_private_key.root.private_key_pem
  certificate_body = tls_locally_signed_cert.root.cert_pem
  certificate_chain = tls_self_signed_cert.ca.cert_pem
}

#######################################
## Server Certificate
#######################################
resource "tls_private_key" "server" {
  algorithm = "RSA"
}

resource "tls_cert_request" "server" {
  key_algorithm = "RSA"
  private_key_pem = tls_private_key.server.private_key_pem
  subject {
    common_name = "${var.prefix}.vpn.server"
    organization = var.organization
  }
}

resource "tls_locally_signed_cert" "server" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  ca_cert_pem = tls_self_signed_cert.ca.cert_pem
  ca_key_algorithm = "RSA"
  ca_private_key_pem = tls_self_signed_cert.ca.private_key_pem
  cert_request_pem = tls_cert_request.server.cert_request_pem
  validity_period_hours = var.validity_period_hours
}

resource "aws_acm_certificate" "server" {
  private_key = tls_private_key.server.private_key_pem
}

#######################################
## Client VPN
#######################################
resource "aws_ec2_client_vpn_endpoint" "this" {
  client_cidr_block = var.cidr_block
  server_certificate_arn = aws_acm_certificate.server.arn
  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.root.arn
  }
  connection_log_options {
    enabled = false
    cloudwatch_log_group = var.cloudwatch_log_group
    cloudwatch_log_stream = var.cloudwatch_log_stream
  }
}

resource "aws_ec2_client_vpn_network_association" "this" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.this.id
  subnet_id = var.subnet_id
  security_groups = var.custom_security_groups
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${var.prefix}-client-vpn-logs"
}
