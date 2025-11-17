terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1.0"
    }
  }
  required_version = ">= 1.9.0"
  backend "azurerm" {
    resource_group_name  = "tfstaterg"
    storage_account_name = "tfstatesa420708643"
    container_name       = "tfstate"
    key                  = "tfdemo.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfrg" {
  name     = "terraformrg"
  location = "Central India"
}

resource "azurerm_storage_account" "example" {
  name                     = "terraformdemosa291025"
  resource_group_name      = azurerm_resource_group.tfrg.name
  location                 = azurerm_resource_group.tfrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}