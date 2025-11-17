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

// comment 1
# comment 2

/* start of Commenting out below section
variable "location" {
  type        = string
  description = "Specify location for resource deploy"
  default = "southindia"
}
*/ # end of commenting

resource "azurerm_resource_group" "tfrg" {
  name     = "terraformrg"
  location = var.location
}

locals {
  commantags = {
    environment = "dev"
    lob         = "banking" #Line Of Business 
    stage       = "alpha"   # alpha, beta
  }

}


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

output "rglocation" {
  value = var.location
}