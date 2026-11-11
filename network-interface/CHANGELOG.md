# Changelog

## [2.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/network-interface-v1.1.0...network-interface-v2.0.0) (2026-11-11)


### ⚠ BREAKING CHANGES

* **windows-vm:** windows-vm creates its own network interface (network_interface_id is gone, subnet_id and the NIC's inputs are new), configures its provider and needs Terraform >= 1.16 and the registry; admin_password is required. Use it as a template, not as a building block.

### Features

* **windows-vm:** a template of its own, with its network interface and import ([44d3271](https://github.com/Opsolete/terraform-modules-examples/commit/44d32718466b8757239cb0c654f95ea56054a6bd))

## [1.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/network-interface-v1.0.0...network-interface-v1.1.0) (2026-11-10)


### Features

* **network-interface:** resource named main, moved from its old name ([4f05753](https://github.com/Opsolete/terraform-modules-examples/commit/4f057537ccaa048c3d081e69bd1151ffee8965d8))

## 1.0.0 (2026-11-10)


### Features

* **network-interface:** a network interface with one private IP, optionally a public IP ([ee5202b](https://github.com/Opsolete/terraform-modules-examples/commit/ee5202b56f5467cd5964081a8c29b95cf1c9a82c))


### Documentation

* a README per building block ([87cd001](https://github.com/Opsolete/terraform-modules-examples/commit/87cd0015a1044cda25323af1ac0aceb046025dff))
