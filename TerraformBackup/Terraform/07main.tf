
resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location # String Constrain Variable
}

/*
resource "azurerm_storage_account" "example" {
  count                    = length(var.storage_account_name)
  name                     = var.storage_account_name[count.index]
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "environment" = var.rTags["environment"] # Map Constrain Variable
  }
}
*/

/*
resource "azurerm_storage_account" "example" {
  count                    = 5
  name                     = "${var.prefix}demosa011125${count.index}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "environment" = var.rTags["environment"] # Map Constrain Variable
  }
}
*/

resource "azurerm_storage_account" "example" {
  for_each                 = var.storage_account_name
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "environment" = var.rTags["environment"] # Map Constrain Variable
  }

  lifecycle {
    # create_before_destroy = true
    # prevent_destroy = true
    ignore_changes = [ 
      tags["environment"]
     ]
  }
}



