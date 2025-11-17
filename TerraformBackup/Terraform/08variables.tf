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