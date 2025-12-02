#######################################
# Azure Provider
#######################################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

#######################################
# Variable Definitions (SHOWS ALL TYPES —
# Two examples EACH)
#######################################

### STRING ###
variable "example_string_1" {
  type        = string
  default     = "eastus"
  description = "Simple region string"
}

variable "example_string_2" {
  type        = string
  default     = "myexample"
  description = "Another string variable"
}

### NUMBER ###
variable "example_number_1" {
  type        = number
  default     = 1
}

variable "example_number_2" {
  type        = number
  default     = 3.14
}

### BOOL ###
variable "example_bool_1" {
  type    = bool
  default = true
}

variable "example_bool_2" {
  type    = bool
  default = false
}

### LIST ###
variable "example_list_1" {
  type    = list(string)
  default = ["eastus", "westus"]
}

variable "example_list_2" {
  type    = list(number)
  default = [1, 2, 3]
}

### SET ###
variable "example_set_1" {
  type    = set(string)
  default = ["tag1", "tag2"]
}

variable "example_set_2" {
  type    = set(number)
  default = [10, 20]
}

### MAP ###
variable "example_map_1" {
  type = map(string)
  default = {
    env  = "dev"
    team = "platform"
  }
}

variable "example_map_2" {
  type = map(number)
  default = {
    replicas = 3
    version  = 2
  }
}

### OBJECT ###
variable "example_object_1" {
  type = object({
    name     = string
    enabled  = bool
    capacity = number
  })
  default = {
    name     = "storageConfigA"
    enabled  = true
    capacity = 100
  }
}

variable "example_object_2" {
  type = object({
    vm_size = string
    cores   = number
  })
  default = {
    vm_size = "Standard_B1s"
    cores   = 1
  }
}

### TUPLE ###
variable "example_tuple_1" {
  type    = tuple([string, number, bool])
  default = ["alpha", 10, true]
}

variable "example_tuple_2" {
  type    = tuple([bool, string])
  default = [false, "beta"]
}

### ANY ###
variable "example_any_1" {
  type    = any
  default = "could-be-anything"
}

variable "example_any_2" {
  type    = any
  default = {
    complex = ["things", 123]
  }
}

### CUSTOM TYPE — Complex structure ###
variable "custom_type_1" {
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "subnet-a"
      cidr = "10.0.1.0/24"
    },
    {
      name = "subnet-b"
      cidr = "10.0.2.0/24"
    }
  ]
}

variable "custom_type_2" {
  type = object({
    tags    = map(string)
    ports   = set(number)
    enabled = bool
  })

  default = {
    tags = {
      app = "example"
      env = "test"
    }
    ports   = [80, 443]
    enabled = true
  }
}

#######################################
# Locals — Demonstrate Usage of Variables
#######################################
locals {
  region          = var.example_string_1

  resource_suffix = "${var.example_string_2}-${var.example_number_1}"

  feature_enabled = var.example_bool_1

  allowed_regions = var.example_list_1

  tag_set_numbers = var.example_set_2

  env_details = var.example_map_1

  vm_config = var.example_object_2

  tuple_data = var.example_tuple_1
  
  dynamic_value = var.example_any_2
}

#######################################
# Azure Resources (Simple but Valid)
#######################################

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.resource_suffix}"
  location = local.region

  tags = local.env_details
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "st${replace(local.resource_suffix, "-", "")}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = local.region
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    enabled = tostring(local.feature_enabled)
    region  = local.region
  }
}

#######################################
# OUTPUTS
#######################################
output "region" {
  value = local.region
}

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}
