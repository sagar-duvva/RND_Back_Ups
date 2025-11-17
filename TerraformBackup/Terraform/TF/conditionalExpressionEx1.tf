resource "random_id" "id" {
  byte_length = 8
}

variable "name" {
  description = "The username assigned to the infrastructure"
  type        = string
  #default     = "terraform"
}

variable "team" {
  description = "The team responsible for the infrastructure"
  type        = string
  default     = "hashicorp"
}

locals {
  name  = var.name != "" ? var.name : random_id.id.hex    # Condiational Expression
  #name  = (var.name != "")[condition] ? (var.name)[if true] : random_id.id.hex[if false]
  owner = var.team
  common_tags = {
    Owner = local.owner
    Name  = local.name
  }
}


output "locValue" {
  value = random_id.id.hex
}