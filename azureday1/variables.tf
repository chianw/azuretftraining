variable "resource-group-name" {
  type    = string
  default = "azureday1rg"
}

variable "resource-group-location" {
  type    = string
  default = "Australia East"
}

variable "nsg-name" {
  type    = string
  default = "azureday1nsg"
}

variable "vnet-name" {
  type    = string
  default = "azureday1-vnet"
}

variable "tag-name" {
  type    = string
  default = "Development"
}