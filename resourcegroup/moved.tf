# Renamed: resources are called main (were self), so existing deployments move instead of being replaced.

moved {
  from = azurerm_resource_group.self
  to   = azurerm_resource_group.main
}
