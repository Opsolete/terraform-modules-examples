# network-security-group

A network security group with its rules, on a network interface. A building block of `virtualmachine`; configures
no provider itself.

**Existing group:** with `existing = true` the group and its association are imported instead of created
(`import.tf`, Terraform ≥ 1.16): the group by its name in the resource group, the association as
`<NIC ID>|<NSG ID>`. Fill in the other inputs, rules too, as they are; the plan shows what would change.
