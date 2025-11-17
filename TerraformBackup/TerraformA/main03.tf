terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.50.0"
    }
  }
  required_version = ">= 1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}


variable "locations" {
  default = ["eastus", "centralindia"]
}

resource "azurerm_resource_group" "exampleRG" {
  name     = "${each.value}-rg"
  for_each = var.locations
  location = each.value
}

output "rg_names_output" {
  value = azurerm_resource_group.exampleRG[each.value].name
}

output "rg_locations_output" {
  value = azurerm_resource_group.exampleRG[each.value].location
}
