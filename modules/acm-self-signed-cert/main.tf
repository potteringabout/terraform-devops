locals {
  hours_in_a_day = 24
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048 // Max size supported by client vpn
}

resource "tls_self_signed_cert" "cert" {
  dns_names             = var.dns_names
  early_renewal_hours   = var.days_before_cert_expiry_to_renew * local.hours_in_a_day
  private_key_pem       = tls_private_key.key.private_key_pem
  validity_period_hours = var.certificate_validity_days * local.hours_in_a_day

  subject {
    common_name = var.common_name
  }
  allowed_uses = [
    "key_agreement",
    "digital_signature",
    "cert_signing",
  ]
}

resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.key.private_key_pem
  certificate_body = tls_self_signed_cert.cert.cert_pem

  tags = {
    Name = var.certificate_name
  }

  lifecycle {
    create_before_destroy = true
  }
}
