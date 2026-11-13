# An existing account (existing = true) is imported instead of created, together with its private endpoint:
# the IDs follow from the inputs. Once in state, Terraform skips these blocks.
locals {
  subscription = join("/", slice(split("/", var.subnet_id), 0, 3)) # /subscriptions/<id>
  group        = "${local.subscription}/resourceGroups/${var.resource_group_name}/providers"
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
