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

variable "client_login_message" {
  description = "Optionally provide a message that will be displayed in a banner when clients connect to the VPN"
  default     = ""
  type        = string
}

variable "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch logs group where client logs will be stored"
  type        = string
}

variable "extra_security_group_rules" {
  description = "Optionally provide extra security group rules to be added to the SG attached to the VPN endpoint"
  default     = []
  type = list(object({
    description = string
    type        = string
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_blocks = set(string)
  }))
}

variable "ipam_pool_id" {
  description = "The ID of the IPAM pool to pull address space for the VPN from"
  type        = string
}

variable "name_prefix" {
  description = "The string to prefix all named resources with"
  default     = ""
  type        = string
}

variable "saml_provider_arn" {
  description = "The ARN of the already configured SAML provider to use for authentication to the VPN endpoint"
  type        = string
}

variable "self_service_saml_provider_arn" {
  description = "The ARN of the already configured SAML provider to use for the self service portal on the VPN endpoint"
  type        = string
}

variable "session_duration_hours" {
  description = "The maximum number of hours a user can be connected before being require to re-authenticate"
  type        = number
  default     = 8
  validation {
    condition     = contains([8, 10, 12, 24], var.session_duration_hours)
    error_message = "Session duration must be one of 8, 10, 12 or 24."
  }
}

variable "self_service_portal" {
  description = "Should the self service portal be enabled for the VPN endpoint?"
  default     = "enabled"
  type        = string
  validation {
    condition     = contains(["enabled", "disabled"], var.self_service_portal)
    error_message = "Must either be enabled or disabled."
  }
}

variable "server_certificate_arn" {
  description = "The ARN of the certificate in ACM that should be used as the VPN server certificate"
  type        = string
}

variable "split_tunneling" {
  description = "If enabled only traffic destined for AWS is sent over the VPN connection."
  type        = bool
  default     = true
}

variable "subnet_name" {
  description = "The name tag on the subnet(s) to assosciate the VPN endpoint with"
  default     = "*access*"
  type        = string
}

variable "vpn_netmask" {
  description = "The size of the CIDR to use for the VPN"
  type        = number
  default     = 22
  validation {
    condition     = var.vpn_netmask >= 0 && var.vpn_netmask <= 128
    error_message = "Netmask has to be in the range 0-128."
  }
}

variable "vpc_name" {
  description = "The VPC where the client VPN should land"
  default     = "euw2-ss-prod"
  type        = string
}

variable "vpn_name" {
  description = "The name for the VPN. Will be prefixed with var.name_prefix"
  default     = "client-vpn"
  type        = string
}

variable "vpn_port" {
  description = "The port number for the Client VPN endpoint"
  type        = number
  default     = 443
  validation {
    condition     = contains([443, 1194], var.vpn_port)
    error_message = "Port must be 443 or 1194."
  }
}

variable "vpn_protocol" {
  description = "The transport protocol to be used by the VPN session"
  default     = "udp"
  type        = string
  validation {
    condition     = contains(["tcp", "udp"], var.vpn_protocol)
    error_message = "The transport protocol must either be tcp or udp."
  }
}
