
# variable "rTags" {
#   type = map(string)
#   default = {
#     "environment" = "staging"
#     "managed_by"  = "terraform"
#     "department"  = "devops"
#   }
# }


# resource "azurerm_resource_group" "example" {
#   name     = "example-resources"
#   location = "West Europe"
# }

# resource "azurerm_network_security_group" "splatexamples" {
#   name                = "acceptanceTestSecurityGroup1"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

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

#   tags = {
#     environment = var.rTags[0].environment    # SplatExpression
#   }
#   tags = ar.rTags[0].environment
# }

# output "var2out" {
#   value = var.rTags[0].environment
# }