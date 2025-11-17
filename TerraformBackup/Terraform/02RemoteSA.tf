terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstaterg" {
  name     = "tfstaterg"
  location = "Central India"
}

resource "azurerm_storage_account" "tfstatesa" {
  name                            = "tfstate${random_string.resource_code.result}"
  resource_group_name             = azurerm_resource_group.tfstaterg.name
  location                        = azurerm_resource_group.tfstaterg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstatesc" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstatesa.id
  container_access_type = "private"
}