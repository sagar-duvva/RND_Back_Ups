terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaterg"
    storage_account_name = "tfstatesa420708643"
    container_name       = "tfstate"
    key                  = "tfdemo.terraform.tfstate"
  }
}