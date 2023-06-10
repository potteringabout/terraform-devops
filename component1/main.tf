terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "tags" {
  type = object({
    project         = string
    account         = string
    accountid       = string
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
