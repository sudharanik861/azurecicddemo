resource "azurerm_network_interface" "terra-demo" {
  name                = "terra-demo-nic"
  location            = azurerm_resource_group.terra-demo.location
  resource_group_name = azurerm_resource_group.terra-demo.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terra-demo.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terra-demo.id
  }
}

resource "azurerm_linux_virtual_machine" "terra-demo" {
  name                = "demovirtualmachine"
  resource_group_name = azurerm_resource_group.terra-demo.name
  location            = azurerm_resource_group.terra-demo.location
  size                = "Standard_B1s"
  admin_username      = "sudhademo"
  network_interface_ids = [
    azurerm_network_interface.terra-demo.id,
  ]

  admin_ssh_key {
    username   = "sudhademo"
    public_key = file("C:/Users/Sudkuruv/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
