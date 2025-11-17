provider "azurerm" {
  features {}
}
locals {
  vnet_list = {
    "vnet1" = [{ "subnet_name" = [
      "subnet1",
      "subnet2",
      "subnet3"
      ]
    }],
    "vnet2" = [{ "subnet_name" = [
      "subnet1",
      "subnet2",
      "subnet3"
      ]
    }],
    "vnet3" = [{ "subnet_name" = [
      "subnet1",
      "subnet2",
      "subnet3"
      ]
    }]
  }
  vnet = merge([
    for vnet_name, vnet in local.vnet_list : {
      for subnet in vnet[0].subnet_name :
      "${vnet_name}-${subnet}" => {
        name        = vnet_name
        subnet_name = subnet
      }
    }
  ]...)
}
data "azurerm_resource_group" "example" {
  name = "myresourcegroup"
}

resource "azurerm_servicebus_namespace" "example" {
  name                = "ansuman-sb-namespace"
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  sku                 = "Premium"

  capacity = 1
}

data "azurerm_subnet" "example" {
  for_each             = local.vnet
  name                 = each.value.subnet_name
  virtual_network_name = each.value.name
  resource_group_name  = data.azurerm_resource_group.example.name
}

resource "azurerm_servicebus_namespace_network_rule_set" "example" {
  namespace_name           = azurerm_servicebus_namespace.example.name
  resource_group_name      = data.azurerm_resource_group.example.name
  default_action           = "Deny"
  trusted_services_allowed = true

  dynamic "network_rules" {
    for_each = data.azurerm_subnet.example
    content {
      subnet_id                            = network_rules.value["id"]
      ignore_missing_vnet_service_endpoint = false
    }
  }
  ip_rules = ["125.123.142.174"]
}
