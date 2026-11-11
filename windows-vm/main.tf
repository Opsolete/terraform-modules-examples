# A Windows VM with its network interface, and optionally data disks, a daily auto-shutdown and a network security
# group: those are building blocks of this repository (their own folders, versions and changelogs), published to
# the registry and composed here. With existing = true it imports a VM made elsewhere instead (import.tf).

locals {
  # by LUN: unique per VM, so adding or removing one disk leaves the others alone
  data_disks = { for d in var.data_disks : tostring(d.lun) => d }
  # What the parts refer to. While importing, the IDs found (import.tf): known when planning, so the parts' own
  # import blocks can be planned even when the plan would replace the VM or NIC; once imported, the same IDs.
  vm_id  = var.existing ? local.existing_vm_id : azurerm_windows_virtual_machine.main.id
  nic_id = var.existing ? local.existing_nic_id : module.nic.id
}

module "nic" {
  source                = "opsolete.localhost:8080/terraform-modules-examples/network-interface/azurerm"
  version               = "~> 1.0"
  name                  = coalesce(var.nic_name, "${var.name}-nic")
  resource_group_name   = var.resource_group_name
  location              = var.location
  subnet_id             = var.subnet_id
  ip_configuration_name = var.ip_configuration_name
  public_ip_address_id  = var.public_ip_address_id
}

resource "azurerm_windows_virtual_machine" "main" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [module.nic.id]

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
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }

  lifecycle {
    # Azure never returns the password: an imported VM has none in state. Azure reports
    # additional_capabilities on every VM; this module doesn't manage it, so an import mustn't plan its removal.
    ignore_changes = [admin_password, additional_capabilities]
  }
}

module "data_disk" {
  source              = "opsolete.localhost:8080/terraform-modules-examples/data-disk/azurerm"
  version             = "~> 1.1" # existing
  for_each            = local.data_disks
  name                = coalesce(each.value.name, "${var.name}-data-${each.key}")
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_machine_id  = local.vm_id
  lun                 = each.value.lun
  size_gb             = each.value.size_gb
  type                = each.value.type
  caching             = each.value.caching
  existing            = each.value.existing
}

module "shutdown_schedule" {
  source               = "opsolete.localhost:8080/terraform-modules-examples/shutdown-schedule/azurerm"
  version              = "~> 1.1" # existing
  count                = var.auto_shutdown_time != null ? 1 : 0
  virtual_machine_id   = local.vm_id
  location             = var.location
  time                 = var.auto_shutdown_time
  timezone             = var.auto_shutdown_timezone
  notification_email   = var.auto_shutdown_notification_email
  notification_minutes = var.auto_shutdown_notification_minutes
  existing             = var.auto_shutdown_existing
}

module "nsg" {
  source               = "opsolete.localhost:8080/terraform-modules-examples/network-security-group/azurerm"
  version              = "~> 1.1" # existing
  count                = var.nsg_name != null ? 1 : 0
  name                 = var.nsg_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  network_interface_id = local.nic_id
  rules                = var.nsg_rules
  existing             = var.nsg_existing
}
