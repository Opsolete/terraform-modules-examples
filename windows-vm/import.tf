# An existing VM (existing = true, e.g. made in the Azure portal) is imported instead of created, with its network
# interface: the VM found by name and resource group, its NIC as the one in that resource group attached to it (a
# VM doesn't report its NICs, a NIC reports its VM). Both through azurerm_resources, not the feature-frozen
# azurerm_virtual_machine family; azurerm refuses to import a Linux VM as a Windows one. Data disks, the
# auto-shutdown and the NSG have switches of their own (data_disks[].existing, auto_shutdown_existing,
# nsg_existing). Once in state, Terraform skips these blocks.

data "azurerm_resources" "vm" {
  count               = var.existing ? 1 : 0
  name                = var.name
  resource_group_name = var.resource_group_name
  type                = "Microsoft.Compute/virtualMachines"

  lifecycle {
    postcondition {
      condition     = length(self.resources) == 1
      error_message = "existing: there is no VM named ${var.name} in resource group ${var.resource_group_name} to import."
    }
  }
}

data "azurerm_resources" "nics" {
  count               = var.existing ? 1 : 0
  resource_group_name = var.resource_group_name
  type                = "Microsoft.Network/networkInterfaces"
}

data "azurerm_network_interface" "existing" {
  for_each            = toset(var.existing ? data.azurerm_resources.nics[0].resources[*].name : [])
  name                = each.key
  resource_group_name = var.resource_group_name
}

locals {
  existing_vm_id = var.existing ? data.azurerm_resources.vm[0].resources[0].id : null
  existing_nic_id = var.existing ? one([
    for n in data.azurerm_network_interface.existing : n.id if lower(n.virtual_machine_id) == lower(local.existing_vm_id)
  ]) : null
}

import {
  for_each = var.existing ? toset(["vm"]) : toset([])
  to       = azurerm_windows_virtual_machine.main
  id       = local.existing_vm_id
}

import {
  for_each = var.existing ? toset(["nic"]) : toset([])
  to       = module.nic.azurerm_network_interface.main
  id       = local.existing_nic_id
}
