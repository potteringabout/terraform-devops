variable "tags" {
  type = object({
    project         = string
    account         = string
    environment     = string
    owner           = string
    email           = string
  })
}

output "tags" {
  value = var.tags
}


