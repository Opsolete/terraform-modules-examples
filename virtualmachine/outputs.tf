output "id" {
  value = coalesce(one(azurerm_windows_virtual_machine.self[*].id), one(azurerm_linux_virtual_machine.self[*].id))
}

output "name" {
  value = var.name
}

output "private_ip_address" {
  value = azurerm_network_interface.self.private_ip_address
}
