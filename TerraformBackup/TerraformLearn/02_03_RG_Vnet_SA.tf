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
resource "azurerm_resource_group" "eus_rg" {
  name     = "terraform-eus-rg"
  location = "eastus"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_account" "eus2_sa" {
  name                     = "terraformeus2sa111125"
  resource_group_name      = azurerm_resource_group.eus_rg.name # defined implicit depends on "eus_rg"
  location                 = "eastus2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_virtual_network" "ci_vnet" {
  name                = "terraformcivnet"
  location            = "centralindia"
  resource_group_name = azurerm_resource_group.eus_rg.name # defined implicit depends on "eus_rg"
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "pre-prod"
  }
}
