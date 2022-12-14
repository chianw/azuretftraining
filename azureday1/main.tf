resource "azurerm_resource_group" "rgexample" {
  name     = var.resource-group-name
  location = var.resource-group-location
}

resource "azurerm_network_security_group" "nsgexample" {
  name                = var.nsg-name
  location            = azurerm_resource_group.rgexample.location
  resource_group_name = azurerm_resource_group.rgexample.name
}

resource "azurerm_virtual_network" "vnetexample" {
  name                = var.vnet-name
  location            = azurerm_resource_group.rgexample.location
  resource_group_name = azurerm_resource_group.rgexample.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
    environment = var.tag-name
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rgexample.name
  virtual_network_name = azurerm_virtual_network.vnetexample.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "nsgtosubnetassociation" {
  subnet_id                 = azurerm_subnet.internal.id
  network_security_group_id = azurerm_network_security_group.nsgexample.id
}

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
