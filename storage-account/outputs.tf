output "id" {
  value = azurerm_storage_account.main.id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.main.primary_blob_endpoint
}

output "private_ip_address" {
  value = azurerm_private_endpoint.blob.private_service_connection[0].private_ip_address
}
