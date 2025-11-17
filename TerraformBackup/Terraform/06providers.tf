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
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}