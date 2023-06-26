locals {
  vpc_dns  = cidrhost(data.aws_vpc.selected.cidr_block, 2) // VPC DNS resolver is always the .2 address of the CIDR block
  vpn_name = "${var.name_prefix}-${var.vpn_name}"
}

resource "aws_vpc_ipam_pool_cidr_allocation" "client_vpn" {
  description    = local.vpn_name
  ipam_pool_id   = var.ipam_pool_id
  netmask_length = var.vpn_netmask
}

resource "aws_cloudwatch_log_stream" "client_vpn" {
  name           = local.vpn_name
  log_group_name = var.cloudwatch_log_group_name
}

resource "aws_ec2_client_vpn_endpoint" "client_vpn" {
  description            = local.vpn_name
  client_cidr_block      = aws_vpc_ipam_pool_cidr_allocation.client_vpn.cidr
  dns_servers            = [local.vpc_dns]
  split_tunnel           = var.split_tunneling
  security_group_ids     = [aws_security_group.vpn.id]
  self_service_portal    = var.self_service_portal
  server_certificate_arn = var.server_certificate_arn
  transport_protocol     = var.vpn_protocol
  vpc_id                 = data.aws_vpc.selected.id
  vpn_port               = var.vpn_port

  authentication_options {
    type                           = "federated-authentication"
    saml_provider_arn              = var.saml_provider_arn
    self_service_saml_provider_arn = var.self_service_saml_provider_arn
  }

  client_login_banner_options {
    enabled     = var.client_login_message != ""
    banner_text = var.client_login_message
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = var.cloudwatch_log_group_name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.client_vpn.name
  }

  tags = {
    Name = local.vpn_name
  }
}

resource "aws_ec2_client_vpn_network_association" "selected_subnets" {
  for_each               = toset(data.aws_subnets.selected.ids)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
  subnet_id              = each.value
}

resource "aws_ec2_client_vpn_authorization_rule" "all_groups" {
  for_each               = var.authorization_rules_for_all_groups
  authorize_all_groups   = true
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
  description            = each.value
  target_network_cidr    = each.key
}

resource "aws_ec2_client_vpn_authorization_rule" "per_group_authorization" {
  for_each               = var.authorization_rules_per_group
  access_group_id        = each.value.group_id
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn.id
  description            = each.value.description
  target_network_cidr    = each.value.target_network_cidr
}
