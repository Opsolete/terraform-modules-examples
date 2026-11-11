# data-disk

An empty managed disk, attached to a VM at a LUN. A building block of `windows-vm` (one per disk); configures
no provider itself. Ignores how an imported disk was first attached (`create_option`).

**Existing disk:** with `existing = true` the disk and its attachment are imported instead of created (`import.tf`,
Terraform ≥ 1.16): the disk by its name in the resource group, the attachment as `<VM ID>/dataDisks/<disk name>`.
Fill in the other inputs as the disk is; the plan shows what would change.
