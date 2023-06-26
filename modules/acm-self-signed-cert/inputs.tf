variable "certificate_name" {
  description = "The name of the certificate stored in ACM"
  default     = "self signed cert"
  type        = string
}

variable "common_name" {
  description = "The CN that will be part of the certificates subject"
  type        = string
}

variable "certificate_validity_days" {
  description = "The number of days the generated certificate will be valid for"
  default     = 90
  type        = number
}

variable "days_before_cert_expiry_to_renew" {
  description = "The number of days before the certificate expires to replace the cert"
  type        = number
  default     = 30
}

variable "dns_names" {
  description = "The DNS names for the certificate"
  type        = list(string)
}
