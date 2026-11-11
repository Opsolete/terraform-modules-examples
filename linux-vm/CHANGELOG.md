# Changelog

## [2.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/linux-vm-v1.1.0...linux-vm-v2.0.0) (2026-11-11)


### ⚠ BREAKING CHANGES

* **windows-vm:** windows-vm creates its own network interface (network_interface_id is gone, subnet_id and the NIC's inputs are new), configures its provider and needs Terraform >= 1.16 and the registry; admin_password is required. Use it as a template, not as a building block.

### Features

* **windows-vm:** a template of its own, with its network interface and import ([44d3271](https://github.com/Opsolete/terraform-modules-examples/commit/44d32718466b8757239cb0c654f95ea56054a6bd))

## [1.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/linux-vm-v1.0.0...linux-vm-v1.1.0) (2026-11-10)


### Features

* **linux-vm:** resource named main, moved from its old name ([912b3b8](https://github.com/Opsolete/terraform-modules-examples/commit/912b3b8820f74ddd63483a91dc032405de3476d5))

## 1.0.0 (2026-11-10)


### Features

* **linux-vm:** a Linux VM with SSH key login on a given network interface ([ab78eee](https://github.com/Opsolete/terraform-modules-examples/commit/ab78eeed40c04afa68865d2082bd9daa4e2dbf09))


### Documentation

* a README per building block ([87cd001](https://github.com/Opsolete/terraform-modules-examples/commit/87cd0015a1044cda25323af1ac0aceb046025dff))
