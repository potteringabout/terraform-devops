variable "account_role_arn" {
  description = "The ARN of role the AWS provider should assume"
  default     = ""
  type        = string
}

variable "authorization_rules_for_all_groups" {
  description = "Provide a map of CIDRS to descriptions that all groups will be authorized to access"
  default     = {}
  type        = map(string)
}

variable "authorization_rules_per_group" {
  description = "Provide authorization rules that only apply to the specified CIDRs"
  default     = []
  type = set(object({
    description         = string // Free text explanation of the rule
    group_id            = string // The ID of the group that is to be granted access
    target_network_cidr = string // The IP range in CIDR notation to allow that group access to
  }))
}

variable "aws_region" {
  default = "eu-west-2"
  type    = string
}

variable "ipam_pool_id" {
  description = "The ID of the IPAM pool to pull address space for the VPN from"
  type        = string
}

variable "server_certificate_arn" {
  description = "The ARN of the certificate in ACM that should be used as the VPN server certificate. If not provided a self signed certificate will be generated."
  default     = ""
  type        = string
}

variable "vpc_name" {
  description = "The VPC where the client VPN should land"
  default     = "euw2-ss-prod"
  type        = string
}

variable "vpn_client_saml_file_path" {
  description = "The path to the saml document to be used by the VPN client"
  type        = string
}

variable "vpn_subnet_name" {
  description = "The name tag on the subnet(s) to assosciate the VPN endpoint with"
  default     = "*access*"
  type        = string
}

variable "vpn_self_service_portal_saml_file_path" {
  description = "The path to the saml document to be used by the VPN self service portal"
  type        = string
}
