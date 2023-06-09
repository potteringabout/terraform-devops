locals {
  project = "potteringabout"
  account = "test"
  environment = "test01"
  accountid = "680805529666"
  region = "eu-west-2"

  #state_key = "state/${local.project}/${local.account}/${local.environment}.tfstate"
  deployment_role  = "arn:aws:iam::${local.accountid}:role/${local.project}-${local.account}-github-deployment"
}

variable "region" {}

variable "deployment_role" {}

terraform {
  backend "s3" {
    #bucket         = "potteringabout-build-${local.project}"
    #key            = "tfstate"
    #region         = "eu-west-2"
    encrypt        = true
    #dynamodb_table = "tflocks"
    
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = var.deployment_role
  }
}

resource "aws_ssm_parameter" "my_param" {
  name  = "foo2"
  type  = "String"
  value = "bar"
}
