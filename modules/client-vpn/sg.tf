resource "aws_security_group" "vpn" {
  name                   = local.vpn_name
  description            = "Security group that is attached to the ${local.vpn_name} client VPN endpoint"
  revoke_rules_on_delete = true // In case SG rules are added from outside of this module
  vpc_id                 = data.aws_vpc.selected.id

  tags = {
    Name = local.vpn_name
  }
}

resource "aws_security_group_rule" "extra_rules" {
  for_each          = toset(var.extra_security_group_rules)
  security_group_id = aws_security_group.vpn.id
  description       = each.value.description
  type              = each.value.type
  protocol          = each.value.protocol
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  cidr_blocks       = each.value.cidr_blocks
}
