variable "tags" {
  type = object({
    project         = string
    account         = string
    environment     = string
    owner           = string
    email           = string
  })
}

variable "vpc_id" {
  type = string
}

variable "alb" {
  type = object({
    name            = string
    subnet_ids      = list(string)
  })
}

module "alb" {
  source          = "git::https://github.com/Allwyn-UK/plat-tfmod-alb.git?ref=v0.0.1"
  name            = "${var.tags["project"]}-${var.tags["environment"]}-${var.alb["name"]}"
  vpc_id          = var.vpc_id
  alb_subnets     = var.alb["subnet_ids"] 
}
