resource "azurerm_network_interface" "self" {
  name                = "${var.name}-nic"
  resource_group_name = var.resource_group_name
  location            = var.location

  # Private IP only, taken from the subnet's address range.
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "self" {
  count                 = var.os_type == "windows" ? 1 : 0
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.self.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  lifecycle {
    precondition {
      condition     = var.admin_password != null
      error_message = "admin_password is required for Windows."
    }
    precondition {
      condition     = length(var.name) <= 15
      error_message = "Windows VM names are at most 15 characters (computer name limit)."
    }
  }
}

resource "azurerm_linux_virtual_machine" "self" {
  count                 = var.os_type == "linux" ? 1 : 0
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.self.id]

  # SSH key only; password login stays disabled (provider default).
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  lifecycle {
    precondition {
      condition     = var.ssh_public_key != null
      error_message = "ssh_public_key is required for Linux."
    }
  }
}
