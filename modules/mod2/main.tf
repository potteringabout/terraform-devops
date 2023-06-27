resource "null_resource" "first_resource" {
  name              = var.my_first_variable
  tags = {
    Name = var.my_first_variable
  }
}

resource "null_resource" "second_resource" {
  name              = var.my_second_variable
  tags = {
    Name = var.my_second_variable
  }
}
