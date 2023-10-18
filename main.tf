module "mod1" {
  source             = "./modules/mod1"
  my_favourite_key   = "/${var.project}/${var.environment}/food"
  my_favourite_value = var.food
}

module "mod2" {
  source             = "./modules/mod2"
  my_favourite_key   = "/${var.project}/${var.environment}/colour"
  my_favourite_value = var.colour
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.config["s3"]["bucket_name"]
}
