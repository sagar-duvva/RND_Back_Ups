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

resource "azurerm_resource_group" "az_rg" {
  name     = local.rg_name
  location = var.rg_location
}

variable "subnet_prefix" {
  type = list(string)
  default = [
    {
      ip   = "10.0.1.0/24"
      name = "subnet-1"
    },
    {
      ip   = "10.0.2.0/24"
      name = "subnet-2"
    }
  ]
}


# resource "azurerm_subnet" "test_subnet" {
#   name                 = lookup(element(var.subnet_prefix, count.index), "name")
#   count                = length(var.subnet_prefix)
#   resource_group_name  = azurerm_resource_group.az_rg.name
#   virtual_network_name = azurerm_virtual_network.lab_vnet.name
#   address_prefix       = lookup(element(var.subnet_prefix, count.index), "ip")
# }

data "azurerm_subnet" "test" {
  name                 = data.azurerm_virtual_network.vnet.subnets[count.index]
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
  count                = count(data.azurerm_virtual_network.vnet.subnets)
}

output "subnet_ids" {
  value = data.azurerm_subnet.test.*.id
}
