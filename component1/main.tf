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
  value = "value1"
}
/*
output "tags" {
  value = var.tags
}*/