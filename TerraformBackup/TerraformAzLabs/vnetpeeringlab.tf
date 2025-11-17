### Provider Block

terraform {
  required_version = ">=1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}

##################





##### EastUS Resources

# Create resource group
resource "azurerm_resource_group" "eastusrg" {
  name     = "eastus_rg"
  location = "East US"
}

# Create virtual network
resource "azurerm_virtual_network" "eastusrgvnet" {
  name                = "eastusrg_network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.eastusrg.location
  resource_group_name = azurerm_resource_group.eastusrg.name
}

# Create subnet
resource "azurerm_subnet" "eastusrgsubnet" {
  name                 = "eastusrg_subnet"
  resource_group_name  = azurerm_resource_group.eastusrg.name
  virtual_network_name = azurerm_virtual_network.eastusrgvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "eastusrgpublicip" {
  name                = "eastusrg_public_ip"
  location            = azurerm_resource_group.eastusrg.location
  resource_group_name = azurerm_resource_group.eastusrg.name
  allocation_method   = "Static"
}

# Create network interface
resource "azurerm_network_interface" "eastusrgnic" {
  name                = "eastusrg_nic"
  location            = azurerm_resource_group.eastusrg.location
  resource_group_name = azurerm_resource_group.eastusrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.eastusrgsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.eastusrgpublicip.id
  }
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "eastusrgnsg" {
  name                = "eastusrg_nsg"
  location            = azurerm_resource_group.eastusrg.location
  resource_group_name = azurerm_resource_group.eastusrg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "eastusrgnicsga" {
  network_interface_id      = azurerm_network_interface.eastusrgnic.id
  network_security_group_id = azurerm_network_security_group.eastusrgnsg.id
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "eastusrgvm" {
  name                = "eastusrg-vm"
  computer_name       = "eus-rg-vm"
  resource_group_name = azurerm_resource_group.eastusrg.name
  location            = azurerm_resource_group.eastusrg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.eastusrgnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-g2"
    version   = "latest"
  }
}

# Install IIS web server to the virtual machine
resource "azurerm_virtual_machine_extension" "eastusrgwsi" {
  name                       = "eastusrg-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.eastusrgvm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}




##### CentraIndia Resources

# Create resource group
resource "azurerm_resource_group" "centralindiarg" {
  name     = "centralindia_rg"
  location = "Central India"
}

# Create virtual network
resource "azurerm_virtual_network" "centralindiargvnet" {
  name                = "centralindiarg_network"
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.centralindiarg.location
  resource_group_name = azurerm_resource_group.centralindiarg.name
}

# Create subnet
resource "azurerm_subnet" "centralindiargsubnet" {
  name                 = "centralindiarg_subnet"
  resource_group_name  = azurerm_resource_group.centralindiarg.name
  virtual_network_name = azurerm_virtual_network.centralindiargvnet.name
  address_prefixes     = ["10.10.2.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "centralindiargpublicip" {
  name                = "centralindiarg_public_ip"
  location            = azurerm_resource_group.centralindiarg.location
  resource_group_name = azurerm_resource_group.centralindiarg.name
  allocation_method   = "Static"
}

# Create network interface
resource "azurerm_network_interface" "centralindiargnic" {
  name                = "centralindiarg_nic"
  location            = azurerm_resource_group.centralindiarg.location
  resource_group_name = azurerm_resource_group.centralindiarg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.centralindiargsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.centralindiargpublicip.id
  }
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "centralindiargnsg" {
  name                = "centralindiarg_nsg"
  location            = azurerm_resource_group.centralindiarg.location
  resource_group_name = azurerm_resource_group.centralindiarg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "centralindiargnicsga" {
  network_interface_id      = azurerm_network_interface.centralindiargnic.id
  network_security_group_id = azurerm_network_security_group.centralindiargnsg.id
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "centralindiargvm" {
  name                = "centralindiarg-vm"
  computer_name       = "ci-rg-vm"
  resource_group_name = azurerm_resource_group.centralindiarg.name
  location            = azurerm_resource_group.centralindiarg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.centralindiargnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-g2"
    version   = "latest"
  }
}

# Install IIS web server to the virtual machine
resource "azurerm_virtual_machine_extension" "centralindiargwsi" {
  name                       = "centralindiarg-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.centralindiargvm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}






##### WestEurope Resources

# Create resource group
resource "azurerm_resource_group" "westeuroperg" {
  name     = "westeurope_rg"
  location = "West Europe"
}

# Create virtual network
resource "azurerm_virtual_network" "westeuropergvnet" {
  name                = "westeuroperg_network"
  address_space       = ["10.20.0.0/16"]
  location            = azurerm_resource_group.westeuroperg.location
  resource_group_name = azurerm_resource_group.westeuroperg.name
}

# Create subnet
resource "azurerm_subnet" "westeuropergsubnet" {
  name                 = "westeuroperg_subnet"
  resource_group_name  = azurerm_resource_group.westeuroperg.name
  virtual_network_name = azurerm_virtual_network.westeuropergvnet.name
  address_prefixes     = ["10.20.2.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "westeuropergpublicip" {
  name                = "westeuroperg_public_ip"
  location            = azurerm_resource_group.westeuroperg.location
  resource_group_name = azurerm_resource_group.westeuroperg.name
  allocation_method   = "Static"
}

# Create network interface
resource "azurerm_network_interface" "westeuropergnic" {
  name                = "westeuroperg_nic"
  location            = azurerm_resource_group.westeuroperg.location
  resource_group_name = azurerm_resource_group.westeuroperg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.westeuropergsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.westeuropergpublicip.id
  }
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "westeuropergnsg" {
  name                = "westeuroperg_nsg"
  location            = azurerm_resource_group.westeuroperg.location
  resource_group_name = azurerm_resource_group.westeuroperg.name

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "web"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "westeuropergnicsga" {
  network_interface_id      = azurerm_network_interface.westeuropergnic.id
  network_security_group_id = azurerm_network_security_group.westeuropergnsg.id
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "westeuropergvm" {
  name                = "westeuroperg-vm"
  computer_name       = "we-rg-vm"
  resource_group_name = azurerm_resource_group.westeuroperg.name
  location            = azurerm_resource_group.westeuroperg.location
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.westeuropergnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-datacenter-g2"
    version   = "latest"
  }
}

# Install IIS web server to the virtual machine
resource "azurerm_virtual_machine_extension" "westeuropergwsi" {
  name                       = "westeuroperg-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.westeuropergvm.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}
