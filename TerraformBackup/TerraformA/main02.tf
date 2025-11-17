provider "azurerm" {
  features {
  }
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}

variable "prefix" {
  default = "terraform"
}

variable "rg_location" {
  default = "centralindia"
}

locals {
  rg_name   = join("-", [var.prefix, "rg"])
  vnet_name = join("-", [var.prefix, "vnet"])
}

##### RESOURCE

resource "azurerm_resource_group" "az_rg" {
  name     = local.rg_name
  location = var.rg_location
}

resource "azurerm_virtual_network" "az_vnet" {
  name                = local.vnet_name
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.az_rg.name
  address_space       = "10.0.0.0/16"
}

resource "azurerm_subnet" "az_snet" {
  name                 = "$(local.vnet_name)-snet"
  resource_group_name  = azurerm_resource_group.az_rg.name
  virtual_network_name = azurerm_virtual_network.az_vnet.name
  address_prefixes     = "10.0.10.0/24"
}



##### OUTPUTS

output "local_rg_name_out" {
  value = local.rg_name
}

output "rg_name_out" {
  value = azurerm_resource_group.az_rg.name
}

output "az_vnet_out" {
  value = azurerm_virtual_network.az_vnet.name
}

output "az_snet_out" {
  value = azurerm_subnet.az_snet.name
}
