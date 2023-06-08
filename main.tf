locals {
  state_key = "state/${local.project}/${local.account}/${local.environment}/${local.component}.tfstate"
  deployment_role  = "arn:aws:iam::${local.accountid}:role/${local.project}-${local.account}-github-deployment"
}

terraform {
  backend "s3" {
    bucket         = "potteringabout-build"
    key            = "${local.state_key}"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "tflocks"
  }
}

provider "aws" {
  assume_role {
    role_arn = "${local.deployment_role}"
  }
}
