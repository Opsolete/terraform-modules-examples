# resourcegroup

One Azure resource group. Ready for Opsolete: the module configures the `azurerm` provider itself
(Opsolete runs a template as the root module), and credentials come from `ARM_TENANT_ID`,
`ARM_SUBSCRIPTION_ID`, `ARM_CLIENT_ID` and `ARM_CLIENT_SECRET` env variables, e.g. a variable set.
