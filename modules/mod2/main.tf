resource "aws_ssm_parameter" "favourite" {
  name        = var.my_favourite_key
  description = "The parameter description"
  type        = "SecureString"
  value       = var.my_favourite_value

  tags = {
    Name = var.my_favourite_key
  }
}