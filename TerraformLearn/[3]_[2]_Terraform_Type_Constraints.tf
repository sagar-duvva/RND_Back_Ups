####################################################################################

#################################################
# main.tf – Terraform Type Constraint Examples  #
# Azure-ready, production-safe, fully commented #
#################################################

terraform {
  required_version = ">= 1.6"
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

############################################
# VARIABLES — All Terraform types with     #
# two examples each                        #
############################################

#############
# 1. STRING #
#############
variable "string_example_1" {
  type        = string
  description = "A simple string."
}

variable "string_example_2" {
  type        = string
  description = "Another simple string."
}

#############
# 2. NUMBER #
#############
variable "number_example_1" {
  type        = number
  description = "A numeric value."
}

variable "number_example_2" {
  type        = number
  description = "Another numeric value."
}

###########
# 3. BOOL #
###########
variable "bool_example_1" {
  type        = bool
  description = "Boolean example."
}

variable "bool_example_2" {
  type        = bool
  description = "Second boolean example."
}

#################
# 4. LIST(TYPE) #
#################
variable "list_string_example_1" {
  type        = list(string)
  description = "List of strings."
}

variable "list_number_example_2" {
  type        = list(number)
  description = "List of numbers."
}

################
# 5. SET(TYPE) #
################
variable "set_string_example_1" {
  type        = set(string)
  description = "Set of strings (unique items)."
}

variable "set_bool_example_2" {
  type        = set(bool)
  description = "Set of booleans."
}

################
# 6. MAP(TYPE) #
################
variable "map_string_example_1" {
  type        = map(string)
  description = "Map of string values."
}

variable "map_number_example_2" {
  type        = map(number)
  description = "Map of numeric values."
}

######################
# 7. OBJECT({ ... }) #
######################
variable "object_example_1" {
  type = object({
    name = string
    size = number
  })
  description = "Object with two simple attributes."
}

variable "object_example_2" {
  type = object({
    project_enabled = bool
    tags            = map(string)
  })
  description = "Object with mixed types."
}

#####################
# 8. TUPLE([ ... ]) #
#####################
variable "tuple_example_1" {
  type = tuple([string, number, bool])
  description = "Tuple with fixed types in order."
}

variable "tuple_example_2" {
  type = tuple([list(string), object({ a = number })])
  description = "More complex tuple example."
}

##########
# 9. ANY #
##########
variable "any_example_1" {
  type        = any
  description = "Can accept any data type."
}

variable "any_example_2" {
  type        = any
  description = "Second freely-typed variable."
}

#######################
# 10. NULL (implicit) #
#######################
variable "null_example_1" {
  type        = string
  default     = null
  description = "Null allowed if type allows it."
}

variable "null_example_2" {
  type        = map(string)
  default     = null
  description = "Map that may be null."
}

############################################
# LOCALS — demonstrating how typed values  #
# normalize into reusable local values     #
############################################

locals {
  example_tags = merge(
    var.map_string_example_1,
    {
      environment = "dev"
      owner       = "terraform-demo"
    }
  )

  example_project_enabled = (
    var.object_example_2.project_enabled ? "enabled" : "disabled"
  )
}

#############################################
# RESOURCES — simple Azure resources using  #
# the above variables to demonstrate types. #
#############################################

resource "azurerm_resource_group" "rg" {
  name     = var.string_example_1
  location = var.string_example_2
  tags     = local.example_tags
}

resource "azurerm_storage_account" "st" {
  name                     = substr("${var.string_example_1}sa", 0, 24)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    example         = local.example_project_enabled
    numeric_setting = tostring(var.number_example_1)
  }
}

####################################################################################