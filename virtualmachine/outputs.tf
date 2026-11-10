output "id" {
  value = coalesce(one(azurerm_windows_virtual_machine.self[*].id), one(azurerm_linux_virtual_machine.self[*].id))
}

output "name" {
  value = var.name
}

output "private_ip_address" {
  value = azurerm_network_interface.self.private_ip_address
}

output "data_disk_ids" {
  value = { for k, d in azurerm_managed_disk.data : k => d.id }
}

output "network_security_group_id" {
  value = one(azurerm_network_security_group.self[*].id)
}
