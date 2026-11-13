# storage-account

A StorageV2 account with public network access off, reached through a private endpoint to its blob
service. Ready for Opsolete: the module configures the `azurerm` provider itself (Opsolete runs a template
as the root module), and credentials come from `ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`, `ARM_CLIENT_ID` and
`ARM_CLIENT_SECRET` env variables, e.g. a variable set.

The provider runs with `data_plane_available = false`: the runner is outside the endpoint's network, so it
can't reach the account's data plane. Containers, queue properties and static websites aren't part of it.

**Import:** with `existing = true` the module imports the account (`name`, `resource_group_name`) and its
private endpoint (`private_endpoint_name`) instead of creating them; the subscription comes from `subnet_id`.

Not included: a private DNS zone group (link the endpoint to `privatelink.blob.core.windows.net` yourself).
