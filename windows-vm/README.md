# windows-vm

A Windows VM with its network interface, and optionally data disks, a daily auto-shutdown and a network security
group. An Opsolete template's module: it configures the azurerm provider itself (credentials from `ARM_*`
environment variables) and composes the `network-interface`, `data-disk`, `shutdown-schedule` and
`network-security-group` building blocks from the registry.

**Importing a VM made elsewhere** (in the Azure portal, say): set `existing`, `name` and `resource_group_name`. The
module finds the VM and its network interface and imports them instead of creating them; the plan shows where the
other settings differ (in Opsolete: *Use found values*, then set what's left). Data disks, the auto-shutdown and the
network security group are imported with their own switches (`existing` per row of `data_disks`,
`auto_shutdown_existing`, `nsg_existing`). `admin_password` is ignored after creation (Azure never returns it), so
an imported VM takes any value.
