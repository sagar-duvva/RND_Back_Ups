resource "azurerm_resource_group" "exampleRG" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_virtual_network" "exampleVNet" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.exampleRG.location
  resource_group_name = azurerm_resource_group.exampleRG.name
}

resource "azurerm_subnet" "exampleSNet" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.exampleRG.name
  virtual_network_name = azurerm_virtual_network.exampleVNet.name
  address_prefixes     = ["10.0.2.0/24"]
}


locals {
  nsg_rules = {
    "allow_http" = {
        priority = 100
        destination_port_range = "80"
        description = "Allow HTTP"
    },
    "allow_https" = {
        priority = 110
        destination_port_range = "443"
        description = "Allow HTTPs"
    }
  }
}


resource "azurerm_network_security_group" "exampleNSG" {
  name                = "example-nsg"
  location            = azurerm_resource_group.exampleRG.location
  resource_group_name = azurerm_resource_group.exampleRG.name

# Dynamic Block 
  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name = security_rule.key
      priority = security_rule.value.priority
      direction = "Inbound"
      access = "Allow"
      protocol = "Tcp"
      source_port_range = "*"
      destination_port_range = security_rule.value.destination_port_range
      source_address_prefix = "*"
      destination_address_prefix = "*"
      description = security_rule.value.description
    }
  }


#   security_rule {
#     name                       = "test123"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.exampleSNet.id
  network_security_group_id = azurerm_network_security_group.exampleNSG.id
}

