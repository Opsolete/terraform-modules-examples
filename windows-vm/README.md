# windows-vm

A Windows VM on a given network interface. A building block of `virtualmachine`; configures no provider itself.
Ignores `admin_password` after creation (Azure never returns it), so imported VMs plan without changes.
