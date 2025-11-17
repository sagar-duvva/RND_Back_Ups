resource "azurerm_resource_group" "tfrg" {
  name     = "terraformrg"
  location = var.location
}