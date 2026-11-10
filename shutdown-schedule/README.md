# shutdown-schedule

A VM's daily auto-shutdown, optionally with an email before it. A building block of `virtualmachine`; configures
no provider itself.

**Existing schedule:** with `existing = true` the schedule is imported instead of created (`import.tf`, Terraform
≥ 1.16), by the name Azure gives it: `shutdown-computevm-<VM name>` in the VM's resource group. Fill in the other
inputs as it is; the plan shows what would change.
