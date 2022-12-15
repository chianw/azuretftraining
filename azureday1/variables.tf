variable "resource_group_name" {
  type    = string
  default = "azureday1rg"
}

variable "resource_group_location" {
  type    = string
  default = "Australia East"
}

variable "virtual_networks" {
  type = map(any)
  default = {
    australia_east = {
      name                = "vnet1"
      location            = "Australia East"
      resource_group_name = "myazuredemorg"
      address_space       = ["10.1.1.0/24"]
      dns_servers         = ["8.8.8.8"]
      tags = {
        environment = "demo"
      }
    }

    southeast_asia = {
      name                = "vnet2"
      location            = "SouthEast Asia"
      resource_group_name = "myazuredemorg"
      address_space       = ["10.1.2.0/24"]
      dns_servers         = ["8.8.8.8"]
      tags = {
        environment = "uat"
      }
    }

    east_us = {
      name                = "vnet3"
      location            = "East US"
      resource_group_name = "myazuredemorg"
      address_space       = ["10.1.3.0/24"]
      dns_servers         = ["8.8.8.8"]
      tags = {
        environment = "production"
      }
    }
  }
}