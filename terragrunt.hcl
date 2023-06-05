locals {
  terraform = yamldecode(file("${get_parent_terragrunt_dir()}/terraform.yml"))
  
  file_inputs = try(jsondecode(file("${get_parent_terragrunt_dir()}/input.tfvars.json")), {})
  
  #inputs = merge( local.file_inputs, local.env_inputs)
  inputs = merge( local.file_inputs )

  project = local.inputs.tags.project
  accountid = local.inputs.accountid
  account = local.inputs.tags.account
  
  component_path = split("/", path_relative_to_include())
  component = element(local.component_path, length(local.component_path)-1) 

  environment = local.inputs.tags.environment
  
  state_key = "state/${local.project}/${local.account}/${local.environment}/${local.component}.tfstate"

  deployment_role  = "arn:aws:iam::${local.accountid}:role/${local.project}-${local.account}-github-deployment"
  
}

inputs = local.inputs

terraform {
  before_hook "before_hook" {
    commands     = ["apply", "plan"]
    execute      = ["tfswitch", "${local.terraform.version}"]
  }
  extra_arguments "disable_input" {
    commands  = get_terraform_commands_that_need_input()
    arguments = ["-input=false"]
  }
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

terraform {
  backend "s3" {
    bucket         = "potteringabout-build"
    key            = "${local.state_key}"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "tflocks"
  }
}

EOF
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF

provider "aws" {
  assume_role {
    role_arn = "${local.deployment_role}"
  }
}


EOF
}