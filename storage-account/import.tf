# An existing account (existing = true) is imported instead of created, together with its private endpoint:
# the IDs follow from the inputs and the provider's subscription. Once in state, Terraform skips these blocks.
data "azurerm_client_config" "current" {}

locals {
  group = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}/providers"
}

import {
  for_each = var.existing ? toset(["main"]) : toset([])
  to       = azurerm_storage_account.main
  id       = "${local.group}/Microsoft.Storage/storageAccounts/${var.name}"
}

import {
  for_each = var.existing ? toset(["main"]) : toset([])
  to       = azurerm_private_endpoint.blob
  id       = "${local.group}/Microsoft.Network/privateEndpoints/${var.private_endpoint_name}"
}
