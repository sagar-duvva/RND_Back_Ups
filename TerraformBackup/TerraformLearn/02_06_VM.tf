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


resource "azurerm_resource_group" "eus_rg" {
  name     = "terraform-eus-rg"
  location = "eastus"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_account" "eus_sa" {
  name                     = "terraformeussa111125"
  resource_group_name      = azurerm_resource_group.eus_rg.name # defined implicit depends on "simple_rg"
  location                 = azurerm_resource_group.eus_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
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

resource "azurerm_network_interface" "eus_nic" {
  name                = "terraform-eus-nic"
  location            = azurerm_resource_group.eus_rg.location
  resource_group_name = azurerm_resource_group.eus_rg.name

  ip_configuration {
    name                          = "internalconfig"
    subnet_id                     = azurerm_subnet.eus_vnet_snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "eus_vm" {
  name                = "terraform-linux-vm"
  computer_name       = "terraform-linux-vm"
  resource_group_name = azurerm_resource_group.eus_rg.name
  location            = azurerm_resource_group.eus_rg.location
  size                = "Standard_B1s"
  admin_username      = "vmadmin"
  network_interface_ids = [
    azurerm_network_interface.eus_nic.id,
  ]
  admin_password                  = "P@ssword1234!"
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 80
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
