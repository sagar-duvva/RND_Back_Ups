resource "azurerm_storage_account" "example" {
  name                     = "terraformdemosa291025"
  resource_group_name      = azurerm_resource_group.tfrg.name
  location                 = azurerm_resource_group.tfrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.commantags.environment
  }
}