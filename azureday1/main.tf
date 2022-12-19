resource "azurerm_resource_group" "rgexample" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "virtual_network" {
  source      = "./modules/virtual_network"
  for_each    = var.virtual_networks
  m_vnet_name = each.value.name
  m_location  = each.value.location
  # m_resource_group_name = azurerm_resource_group.rgexample.name
  m_resource_group_name = each.value.resource_group_name
  m_address_space       = each.value.address_space
  m_dns_servers         = each.value.dns_servers
  m_tag_name            = each.value.tags

  depends_on = [
    azurerm_resource_group.rgexample
  ]
}

output "virtual_network" {
  value = module.virtual_network
}


# output "vnet_properties" {
#   value = module.virtual_network["australia_east"]
# }

output "vnet_properties" {
  value = [for virtualnetwork in module.virtual_network : virtualnetwork.name]
}

# resource "azurerm_virtual_network_peering" "vnet1-vnet2" {
#   name                      = "peer1to2"
#   resource_group_name       = azurerm_resource_group.rgexample.name
#   virtual_network_name      = vnet_properties["australia_east"].vnet_name
#   remote_virtual_network_id = vnet_properties["east_us"].vnet_id
# }

# resource "azurerm_virtual_network_peering" "example-2" {
#   name                      = "peer2to1"
#   resource_group_name       = azurerm_resource_group.rgexample.name
#   virtual_network_name      = azurerm_virtual_network.vnetexample1.name
#   remote_virtual_network_id = azurerm_virtual_network.vnetexample.id
# }

# resource "azurerm_subnet" "internal" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.rgexample.name
#   virtual_network_name = azurerm_virtual_network.vnetexample.name
#   address_prefixes     = ["10.0.1.0/24"]
# }

# resource "azurerm_subnet_network_security_group_association" "nsgtosubnetassociation" {
#   subnet_id                 = azurerm_subnet.internal.id
#   network_security_group_id = azurerm_network_security_group.nsgexample.id
# }

# resource "azurerm_network_security_group" "nsgexample" {
#   name                = var.nsg-name
#   location            = azurerm_resource_group.rgexample.location
#   resource_group_name = azurerm_resource_group.rgexample.name
# }

/*
resource "azurerm_network_interface" "vm-nic" {
  name                = "vm-nic"
  location            = azurerm_resource_group.rgexample.location
  resource_group_name = azurerm_resource_group.rgexample.name

  ip_configuration {
    name                          = "ipconfiguration1"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = "mylinuxvm"
  location              = azurerm_resource_group.rgexample.location
  resource_group_name   = azurerm_resource_group.rgexample.name
  network_interface_ids = [azurerm_network_interface.vm-nic.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

*/