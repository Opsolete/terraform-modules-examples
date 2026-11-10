resource "azurerm_network_interface" "self" {
  name                = coalesce(var.nic_name, "${var.name}-nic")
  resource_group_name = var.resource_group_name
  location            = var.location

  # Private IP only, taken from the subnet's address range.
  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
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

  # Managed boot diagnostics (no storage account): on in VMs made in the portal.
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_enabled ? [1] : []
    content {}
  }

  secure_boot_enabled = var.secure_boot_enabled
  vtpm_enabled        = var.vtpm_enabled

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = coalesce(var.image_publisher, "MicrosoftWindowsServer")
    offer     = coalesce(var.image_offer, "WindowsServer")
    sku       = coalesce(var.image_sku, "2022-datacenter-azure-edition")
    version   = "latest"
  }

  lifecycle {
    # Azure never returns the password: an adopted (imported) VM has none in state. Azure reports
    # additional_capabilities on every VM; this module doesn't manage it, so an import mustn't plan its removal.
    ignore_changes = [admin_password, additional_capabilities]
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

  # Managed boot diagnostics (no storage account): on in VMs made in the portal.
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_enabled ? [1] : []
    content {}
  }

  secure_boot_enabled = var.secure_boot_enabled
  vtpm_enabled        = var.vtpm_enabled

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = coalesce(var.image_publisher, "Canonical")
    offer     = coalesce(var.image_offer, "ubuntu-24_04-lts")
    sku       = coalesce(var.image_sku, "server")
    version   = "latest"
  }

  lifecycle {
    # Azure reports additional_capabilities on every VM; this module doesn't manage it (see the Windows VM).
    ignore_changes = [additional_capabilities]
    precondition {
      condition     = var.ssh_public_key != null
      error_message = "ssh_public_key is required for Linux."
    }
  }
}

locals {
  vm_id = coalesce(one(azurerm_windows_virtual_machine.self[*].id), one(azurerm_linux_virtual_machine.self[*].id))
  # by LUN: unique per VM, so adding or removing one disk leaves the others alone
  data_disks = { for d in jsondecode(var.data_disks_json) : tostring(d.lun) => d }
  nsg_rules  = jsondecode(var.nsg_rules_json)
}

# Data disks, empty, each attached at its LUN.
resource "azurerm_managed_disk" "data" {
  for_each             = local.data_disks
  name                 = coalesce(try(each.value.name, null), "${var.name}-data-${each.key}")
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = try(each.value.type, "Standard_LRS")
  create_option        = "Empty"
  disk_size_gb         = each.value.size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "data" {
  for_each           = local.data_disks
  managed_disk_id    = azurerm_managed_disk.data[each.key].id
  virtual_machine_id = local.vm_id
  lun                = each.value.lun
  caching            = try(each.value.caching, "ReadWrite")

  lifecycle {
    # How the disk was first attached (Attach, or Empty for a disk made with the VM in the portal): it only
    # matters then, so an imported attachment mustn't plan its replacement.
    ignore_changes = [create_option]
  }
}

# Daily auto-shutdown, optionally with an email before it.
resource "azurerm_dev_test_global_vm_shutdown_schedule" "self" {
  count                 = var.auto_shutdown_time != null ? 1 : 0
  virtual_machine_id    = local.vm_id
  location              = var.location
  enabled               = true
  daily_recurrence_time = var.auto_shutdown_time
  timezone              = var.auto_shutdown_timezone

  notification_settings {
    enabled         = var.auto_shutdown_notification_email != null
    email           = var.auto_shutdown_notification_email
    time_in_minutes = var.auto_shutdown_notification_minutes
  }
}

# A network security group of the VM's own, on its network interface.
resource "azurerm_network_security_group" "self" {
  count               = var.nsg_name != null ? 1 : 0
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location

  dynamic "security_rule" {
    for_each = local.nsg_rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = try(security_rule.value.direction, "Inbound")
      access                     = try(security_rule.value.access, "Allow")
      protocol                   = try(security_rule.value.protocol, "Tcp")
      source_port_range          = try(security_rule.value.source_port_range, "*")
      destination_port_range     = try(security_rule.value.destination_port_range, "*")
      source_address_prefix      = try(security_rule.value.source_address_prefix, "*")
      destination_address_prefix = try(security_rule.value.destination_address_prefix, "*")
      description                = try(security_rule.value.description, "")
    }
  }
}

resource "azurerm_network_interface_security_group_association" "self" {
  count                     = var.nsg_name != null ? 1 : 0
  network_interface_id      = azurerm_network_interface.self.id
  network_security_group_id = azurerm_network_security_group.self[0].id
}
