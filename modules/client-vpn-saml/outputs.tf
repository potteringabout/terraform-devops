output "self_service_portal_arn" {
  value = aws_iam_saml_provider.self_service_portal.arn
}

output "vpn_client_arn" {
  value = aws_iam_saml_provider.vpn_client.arn
}
