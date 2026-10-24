resource "azurerm_resource_group" "self" {
  name     = var.name
  location = var.location
}
