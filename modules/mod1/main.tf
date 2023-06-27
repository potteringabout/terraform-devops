resource "aws_ssm_parameter" "favourite_number" {
  name        = var.my_favourite_number_key
  description = "The parameter description"
  type        = "SecureString"
  value       = var.my_favourite_number_value

  tags = {
    Name = var.my_favourite_number_key
  }
}

