#########################################################

/*
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.1.0"
      # Provider Version located at hashicorp
      # Operator "~>" & Version "4.1.0"
      # Meaning TF can use any version from 4.1.0 to 4.1.10 but not 4.2.0
    }
  }
  required_version = ">= 1.9.0"
  # Installed Terraform Client Version
  # Operator ">=" & Version "1.13.0"
  # Meaning TF can use equalent or higher than 1.13.0 but not lower version
}

provider "azurerm" {
  features {}
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}
*/



/*
===Operators===
= Exact Version
!= Exclude The Exact Version
>,>=,<,<= Allow version when comparison is true
~> only allow the rightmost to increment
  e.g.
  for 1.0.4 TF can install 1.0.5 or 1.0.10 but not 1.1.0
  for 1.1 TF can install 1.2 or 1.10 But not 2.0
=======
*/

#########################################################

terraform {
  required_version = ">=1.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.50.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}
