module "mod1" {
  source      = "./modules/mod1"
  name        = var.my_first_variable
}

module "mod2" {
  source      = "./modules/mod2"
  name        = var.my_first_variable
}
