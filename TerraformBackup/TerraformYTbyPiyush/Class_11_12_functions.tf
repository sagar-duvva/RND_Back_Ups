## Terraform provider


provider "azurerm" {
  features {}
  subscription_id = "9352ae6b-6fbe-4ecc-9e80-10bb531a69e1"
}


locals {
  max_number = max(12,24,22,32)
  to_lower = lower("HELLO WORLD THIS IS ALL CAPS")
  trim_start_end = trim(" Hello ", " ")
  trim_start_end_1= trim("Ex HelloEx ", "Ex ")
  trim_start_end_2= trim("Ex Hello Ex ", "Ex")
}

output "max_number_out" {
  value = local.max_number  #out: "+ max_number_out = 32"
}
output "min_number_out" {
  value = min(12,24,22,32)  #out: "+ min_number_out = 12"
}
output "to_lower_out" {
  value = local.to_lower  #out: '+ to_lower_out   = "hello world this is all caps"'
}
output "trim_out" {
  value = local.trim_start_end  #out: "+ trim_out       = "Hello""
}
output "trim_out1" {
  value = local.trim_start_end_1  #out: "+ trim_out1      = "Hello""
}
output "trim_out2" {
  value = local.trim_start_end_2  #out: "+ trim_out2      = " Hello Ex ""
}
output "chomp_out" {
  value = chomp("hello\n")
}
output "reverse_out" {
  value = reverse(["d","c","b","a"])
}

# Assignment
# https://github.com/piyushsachdeva/Terraform-Full-Course-Azure/tree/main/lessons/day11-12


###
### Assignment 1: Project Naming Convention
###

/*
# Assignment 1: Project Naming Convention
Functions Focus: lower, replace

Scenario:
Your company requires all resource names to be lowercase and replace spaces with hyphens.

Input:

"Project ALPHA Resource"
Required Output:

"project-alpha-resource"
Tasks:

Create a variable project_name with the given input
Create a local that uses the required functions
Use the transformed name to create an Azure resource group
Add an output to display the transformed name
*/

variable "project_name" {
  default = "Project ALPHA Resource"
}

locals {
  transformed_name = lower(replace(var.project_name, " ", "-"))
}

resource "azurerm_resource_group" "rg" {
  name = local.transformed_name
  location = "centralindia"
}

output "Assignment1_Result" {
  value = azurerm_resource_group.rg.name
}

###
### Assignment 2: Resource Tagging
###
/*
# Assignment 2: Resource Tagging
Function Focus: merge

Scenario:
You need to combine default company tags with environment-specific tags.

Input:

# Default tags
{
    company    = "TechCorp"
    managed_by = "terraform"
}

# Environment tags
{
    environment  = "production"
    cost_center = "cc-123"
}
Tasks:

Create locals for both tag sets
Merge them using the appropriate function
Apply them to a resource group
Create an output to display the combined tags
*/

variable "default_tags" {
  type = map(string)
  default = {
    company    = "TechCorp"
    managed_by = "terraform"
  }
}

variable "environment_tags" {
  type = map(string)
  default = {
    environment  = "production"
    cost_center = "cc-123"
  }
}

locals {
  merge_tags = merge(var.default_tags, var.environment_tags)
}

resource "azurerm_resource_group" "mergeRG" {
  name = "mergeRG"
  location = "centralindia"
  tags = local.merge_tags
}

output "merge_tags_out" {
  value = local.merge_tags
}

###
### Assignment 3: Storage Account Naming
###
/*
Assignment 3: Storage Account Naming
Function Focus: substr

Scenario:
Azure storage account names must be less than 24 characters and use only lowercase letters and numbers.

Input:

"projectalphastorageaccount"
Requirements:

Maximum length: 23 characters
All lowercase
No special characters
Tasks:

Create a function to process the storage account name
Ensure it meets Azure requirements
Apply it to a storage account resource
Add validation to prevent invalid names
*/


variable "raw_string" {
  default = "Hello@World#This!Is$TerraformProjectal!PHASEStorage@account"
}


locals {
  # Converted to Lowercase, Remove any non-alphanumeric characters & Truncate to a maximum length of 23 characters in one go
  cleaned_raw_string = substr(replace(lower(var.raw_string), "/[^a-zA-Z0-9_-]/", ""), 0, 23)
}

output "cleaned_raw_string" {
  value = local.cleaned_raw_string
}

locals {

  # Step 1: Convert to lowercase
  lowercased_name = lower(var.raw_string)

  # Step 2: Remove any non-alphanumeric characters (just in case)
  #sanitized_name = replace(local.lowercased_name, "/[^a-zA-Z0-9_-]/", "")
  sanitized_name = replace(local.lowercased_name, "/[^a-z0-9_-]/", "")

  # Step 3: Truncate to a maximum length of 23 characters
  truncated_name = substr(local.sanitized_name, 0, 23)

}

output "storage_account_name" {
  value = local.truncated_name
}


###
### Assignment 4: Network Security Group Rules
###
/*
Assignment 4: Network Security Group Rules
Functions Focus: split, join

Scenario:
Transform a comma-separated list of ports into a specific format for documentation.

Input:

"80,443,8080,3306"
Required Output:

"port-80-port-443-port-8080-port-3306"
Tasks:

Create a variable for the port list
Transform it using appropriate functions
Create an output with the formatted result
Add validation for port numbers
*/

locals {
  ports = "80,443,8080,3306"
  spliting = split(",", local.ports)
  joining = join("port", local.spliting)
  formatted_ports = [for p in local.spliting : "port-${p}"]
  formmated_joining =  [for a in local.spliting: join("port-", a)]
}

output "joining" {
  value = local.joining
}
output "formatted_ports" {
  value = local.formatted_ports
}
/*
Assignment 5: Resource Lookup
Function Focus: lookup

Scenario:
Implement environment configuration mapping with fallback values.

Input:

environments = {
    dev = {
        instance_size = "small"
        redundancy    = "low"
    }
    prod = {
        instance_size = "large"
        redundancy    = "high"
    }
}
Tasks:

Create the environments map
Implement lookup with fallback
Create outputs for the configuration
Handle invalid environment names
*/

/*
Terraform functions fall into categories like:
> String functions (e.g., join(), lower(), upper())
> Numeric functions (e.g., max(), min(), abs())
> Collection functions (e.g., length(), flatten(), distinct())
> Date and time functions (e.g., timestamp(), timeadd())
> Encoding functions (e.g., jsonencode(), base64decode())
> Other utility functions (e.g., lookup(), merge(), element())
*/


