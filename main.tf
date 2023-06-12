#locals {
#  project = "potteringabout"
#  account = "test"
#  environment = "test01"
#  accountid = "680805529666"
#  region = "eu-west-2"

  #state_key = "state/${local.project}/${local.account}/${local.environment}.tfstate"
#  deployment_role  = "arn:aws:iam::${local.accountid}:role/${local.project}-${local.account}-github-deployment"
#}*/

variable "region" {}

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


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.tags["accountid"]}:role/${var.tags["project"]}-${var.tags["account"]}-github-deployment"
  }
}

resource "aws_ssm_parameter" "my_param" {
  #checkov:skip=CKV_AWS_337:The bucket is a public static content host
  name  = "foo2"
  value = "bar"
  type  = "SecureString"
}

module "component1" {
  source = "./component1"
  tags = var.tags
}

module "component2" {
  source = "./component2"
  tags = var.tags
}
