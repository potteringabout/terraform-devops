resource "aws_iam_saml_provider" "self_service_portal" {
  name                   = "${var.name_prefix}-client-vpn-self-service-portal"
  saml_metadata_document = file("${path.module}/${var.vpn_self_service_portal_saml_file_path}")
  tags = {
    Name = "${var.name_prefix}-client-vpn-self-service-portal"
  }
}

resource "aws_iam_saml_provider" "vpn_client" {
  name                   = "${var.name_prefix}-client-vpn"
  saml_metadata_document = file("${path.module}/${var.vpn_client_saml_file_path}")
  tags = {
    Name = "${var.name_prefix}-client-vpn"
  }
}
