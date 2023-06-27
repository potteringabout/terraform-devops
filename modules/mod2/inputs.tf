variable "my_favourite_number_key" {
  description = "A descriptive description :)"
  default     = "myfav"
  type        = string
}

variable "my_favourite_number_value" {
  description = "A descriptive description :)"
  default     = 1
  type        = number
  validation {
    condition     = contains(
      var.my_favourite_number_value > 0 &&
      var.my_favourite_number_value < 10
    )
    error_message = "Valid values for my_favourite_number_value are between 0 and 10"
  }
}