variable "name_prefix" {
  description = "The string to prefix all named resources with"
  default     = ""
  type        = string
}

variable "days_to_keep_logs" {
  description = "The number of days logs will be retained in CloudWatch. For indefinite retention use 0."
  default     = 365
  type        = number
  validation {
    condition     = contains([0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653], var.days_to_keep_logs)
    error_message = "Valid values for log retention are 0, 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288 or 3653."
  }
}
