#######################################################################
### TERRAFORM PROVIDER BLOCK
terraform {
  required_version = ">=1.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.50.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}
#######################################################################
#
resource "azurerm_resource_group" "simple_rg" {
  name     = "terraform-eus2-rg"
  location = "eastus2"
}

resource "azurerm_storage_account" "eus2_sa" {
  name                     = "terraformeussa111125"
  resource_group_name      = azurerm_resource_group.simple_rg.name # defined implicit depends on "simple_rg"
  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
