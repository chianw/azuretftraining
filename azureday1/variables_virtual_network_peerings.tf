
variable "virtual_network_peerings" {
  type = map(any)
  default = {
    australia_east = {
      peerings = {
        east_us = {
          name                         = "au-eastus"
          resource_group_name          = "myazuredemorg"
          allow_virtual_network_access = true
          allow_gateway_transit        = true
          allow_forwarded_traffic      = true
        }

        southeast_asia = {
          name                         = "au-southeastasia"
          resource_group_name          = "myazuredemorg"
          allow_virtual_network_access = false
          allow_gateway_transit        = false
        }
      }
    }

    southeast_asia = {
      peerings = {
        east_us = {
          name                = "southeastasia-eastus"
          resource_group_name = "myazuredemorg"
        }

        australia_east = {
          name                = "southeastasia_au"
          resource_group_name = "myazuredemorg"
        }
      }
    }

    east_us = {
      peerings = {
        southeast_asia = {
          name                = "eastus_southeastasia"
          resource_group_name = "myazuredemorg"
        }

        australia_east = {
          name                = "eastus_au"
          resource_group_name = "myazuredemorg"
        }
      }
    }
  }
}