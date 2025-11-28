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
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}


variable "location" {
  type        = string # String Type Constrain
  description = "Specify location for resource deploy"
  default     = "centralindia"
}

variable "prefix" {
  type    = string # String Type Constrain
  default = "prepod"
}


# List Type Constrain == It allows duplicate values as well
variable "allowed_location" {
  type    = list(string)
  default = ["centralindia", "southindia", "centralindia", "westindia"]
}

# Map Type constrain
variable "rTags" {
  type = map(string)
  default = {
    "environment" = "staging"
    "managed_by"  = "terraform"
    "department"  = "devops"
  }
}

# Tuple Type constrain
variable "network_config" {
  type    = tuple([string, string, number])
  default = ["10.0.0.0/16", "10.0.10.0", 24]
}

/*
# used with count length
variable "storage_account_name" {
  type    = list(string)
  default = [ "terraformdemosa011125", "terraformdemosa0111251" ]
}
*/

variable "storage_account_name" {
  type    = set(string)
  default = [ "terraformdemosa011125", "terraformdemosa0111251" ]
}



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
  for_each = var.storage_account_name
  name                     = each.value
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    "environment" = var.rTags["environment"] # Map Constrain Variable
  }
}


output "rgname" {
  value = azurerm_resource_group.example.name
}

output "sa_name" {
  value = [ for i in azurerm_storage_account.example: i.name ]
}