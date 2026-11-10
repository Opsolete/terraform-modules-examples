# data-disk

An empty managed disk, attached to a VM at a LUN. A building block of `virtualmachine` (one per disk); configures
no provider itself. Ignores how an imported disk was first attached (`create_option`).
