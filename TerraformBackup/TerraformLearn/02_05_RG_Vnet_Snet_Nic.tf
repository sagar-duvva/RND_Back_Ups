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

resource "azurerm_virtual_network" "eus_vnet" {
  name                = "terraform-eus-vnet"
  location            = azurerm_resource_group.eus_rg.location
  resource_group_name = azurerm_resource_group.eus_rg.name # defined implicit depends on "eus_rg"
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "pre-prod"
  }
}


resource "azurerm_subnet" "eus_vnet_snet" {
  name                 = "terraform-eus-vnet-snet"
  resource_group_name  = azurerm_resource_group.eus_rg.name
  virtual_network_name = azurerm_virtual_network.eus_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "eus-nic" {
  name                = "terraform-eus-nic"
  location            = azurerm_resource_group.eus_rg.location
  resource_group_name = azurerm_resource_group.eus_rg.name

  ip_configuration {
    name                          = "internalconfig"
    subnet_id                     = azurerm_subnet.eus_vnet_snet.id
    private_ip_address_allocation = "Dynamic"
  }
}
