variable "tags" {
  type = object({
    project         = string
    account         = string
    environment     = string
    owner           = string
    email           = string
  })
}

variable "vpc_id" {}

variable "alb" {
  type = object({
    name            = string
    subnet_ids      = list(string)
  })
}

variable "alb_subnets" {
  type = list
}

module "alb" {
  source          = "git@github.com:Allwyn-UK/plat-tfmod-alb.git?ref=v0.0.1"
  name            = "${var.tags["project"]}-${var.tags["environment"]}-${var.alb["name"]}"
  vpc_id          = var.vpc_id
  alb_subnets     = var.alb["subnet_ids"] 
}