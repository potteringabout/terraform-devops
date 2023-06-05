variable "tags" {
  type = object({
    project         = string
    account         = string
    environment     = string
    owner           = string
    email           = string
  })
}

resource "aws_ssm_parameter" "my_param" {
  name  = "foo"
  type  = "String"
  value = "bar"
}

output "var1" {
  value = aws_ssm_parameter.my_param.name
}

output "tags" {
  value = var.tags
}