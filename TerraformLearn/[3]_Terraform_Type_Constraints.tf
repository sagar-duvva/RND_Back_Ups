############################################################
# Terraform Type Constraints — Beginner-Friendly Teaching
# (Included as comments so the final output is a single main.tf file)
#
# ──────────────────────────────────────────────────────────
# 1. WHAT ARE TYPE CONSTRAINTS?
# Type constraints tell Terraform what type of value a variable must have.
# They prevent configuration errors by validating inputs before apply.
#
# ──────────────────────────────────────────────────────────
# 2. HOW TERRAFORM VALIDATES TYPES
# • At "terraform plan", Terraform checks variable values against any type
#   constraints.
# • If the value doesn’t match, Terraform throws an error before doing anything.
#
# ──────────────────────────────────────────────────────────
# 3. THREE GROUPS OF TYPES
#
# ─ Primitive types ─
#   - string       A sequence of characters
#   - number       Any numeric value
#   - bool         True/false
#
# ─ Collection types ─
#   - list(<type>)     Ordered sequence, values of same type
#   - map(<type>)      Key/value pairs, values of same type
#   - set(<type>)      Unique values, same type
#
# ─ Structural types ─
#   - object({...})    Keys each have specified types
#   - tuple([...])     Ordered list with individually-specified types for each item
#
# ──────────────────────────────────────────────────────────
# 4. COMMON MISTAKES
# • Giving wrong types (e.g., number stored as string)
# • Mismatched element types in lists/sets/maps
# • Missing required object attributes
#
# ──────────────────────────────────────────────────────────
# This configuration contains:
# • 2 examples of each primitive type
# • 2 examples of each collection type
# • 2 examples of each structural type
# All used in realistic Azure resources.
############################################################


terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
}

###############################
# VARIABLE DEFINITIONS
###############################

# ───── PRIMITIVE TYPES ─────
variable "location" {
  description = "Azure region (primitive string)"
  type        = string
}

variable "enable_logs" {
  description = "Enable diagnostic logs (primitive bool)"
  type        = bool
}

variable "vm_count" {
  description = "Number of VMs (primitive number example 1)"
  type        = number
}

variable "tag_environment" {
  description = "Tag for naming resources (primitive string example 2)"
  type        = string
}

# ───── COLLECTION TYPES ─────
variable "subnet_names" {
  description = "List of subnet names (list(string) example 1)"
  type        = list(string)
}

variable "ports" {
  description = "Set of allowed ports (set(number) example 2)"
  type        = set(number)
}

variable "metadata_tags" {
  description = "Map of string tags (map(string) example 1)"
  type        = map(string)
}

variable "cost_center_codes" {
  description = "Map of numeric cost centers (map(number) example 2)"
  type        = map(number)
}

# ───── STRUCTURAL TYPES ─────
variable "storage_config" {
  description = "Object describing storage account (object example 1)"
  type = object({
    name     = string
    tier     = string
    replication = string
  })
}

variable "vm_specs" {
  description = "Tuple describing VM information (tuple example 1)"
  type        = tuple([string, number, bool])
}

variable "firewall_rules" {
  description = "List of firewall rule objects (object example 2)"
  type = list(object({
    name        = string
    start_ip    = string
    end_ip      = string
  }))
}

variable "mixed_tuple" {
  description = "Tuple of mixed types (tuple example 2)"
  type        = tuple([string, bool, number])
}

###############################
# RESOURCE GROUP
###############################

resource "azurerm_resource_group" "rg" {
  name     = "tf-type-demo-${var.tag_environment}"
  location = var.location
}

###############################
# VIRTUAL NETWORK + SUBNETS
###############################

resource "azurerm_virtual_network" "vnet" {
  name                = "tf-type-demo-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = var.metadata_tags
}

resource "azurerm_subnet" "subnets" {
  for_each             = toset(var.subnet_names)
  name                 = each.value
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.${index(var.subnet_names, each.value)}.0/24"]
}

###############################
# STORAGE ACCOUNT (OBJECT TYPE)
###############################

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_config.name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.storage_config.tier
  account_replication_type = var.storage_config.replication

  tags = {
    environment = var.tag_environment
  }
}

###############################
# NETWORK SECURITY GROUP (SET + MAP)
###############################

resource "azurerm_network_security_group" "nsg" {
  name                = "tf-type-demo-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.ports
    content {
      name                       = "allow-port-${security_rule.value}"
      priority                   = 200 + security_rule.value
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

###############################
# FIREWALL RULES (STRUCTURAL OBJECT LIST)
###############################

resource "azurerm_storage_account_network_rules" "fw" {
  storage_account_id = azurerm_storage_account.sa.id

  default_action             = "Deny"
  bypass                     = ["AzureServices"]

  ip_rules = [
    for rule in var.firewall_rules : rule.start_ip
  ]
}

###############################
# VIRTUAL MACHINES
###############################

resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "tf-nic-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnets[var.subnet_names[0]].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.vm_count
  name                = "tf-vm-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_specs[0]               # from tuple: string type
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  admin_password = "P@ssword1234!"                    # demo only

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # Using tuple (mixed_tuple)
  tags = {
    component = var.mixed_tuple[0]
    enabled   = tostring(var.mixed_tuple[1])
    scale     = tostring(var.mixed_tuple[2])
  }
}

###############################
# OUTPUTS
###############################

output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "vm_private_ips" {
  value = [
    for nic in azurerm_network_interface.nic : nic.private_ip_address
  ]
}
