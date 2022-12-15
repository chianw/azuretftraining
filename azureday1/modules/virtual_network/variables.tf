variable "m_resource_group_name" {
  type    = string
  default = "azureday1rg"
}

variable "m_location" {
  type    = string
  default = "Australia East"
}

variable "m_vnet_name" {
  type    = string
  default = "azureday1-vnet"
}

variable "m_address_space" {
  type    = list(any)
  default = ["10.0.0.0/16"]
}

variable "m_dns_servers" {
  type    = list(any)
  default = ["10.0.0.4", "10.0.0.5"]
}

variable "m_tag_name" {
  type = map(any)
  default = {
    environment = "demo"
  }
}