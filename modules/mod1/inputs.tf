variable "my_first_variable" {
  description = "A descriptive description :)"
  default     = ""
  type        = string
}

variable "my_second_variable" {
  description = "A descriptive description :)"
  default     = 1
  type        = number
  validation {
    condition     = contains(
      var.my_second_variable > 0 &&
      var.my_second_variable < 10
    )
    error_message = "Valid values for my_second_variable are between 0 and 10"
  }
}
