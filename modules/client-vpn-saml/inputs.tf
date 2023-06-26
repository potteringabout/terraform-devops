variable "name_prefix" {
  description = "The string to prefix all named resources with"
  default     = ""
  type        = string
}

variable "vpn_client_saml_file_path" {
  description = "The file path relative to this module to the saml document to be used by the VPN client."
  type        = string
}

variable "vpn_self_service_portal_saml_file_path" {
  description = "The file path relative to this module to the saml document to be used by the VPN self service portal"
  type        = string
}
