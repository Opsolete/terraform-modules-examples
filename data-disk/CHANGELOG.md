# Changelog

## [2.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/data-disk-v1.1.0...data-disk-v2.0.0) (2026-11-11)


### ⚠ BREAKING CHANGES

* **windows-vm:** windows-vm creates its own network interface (network_interface_id is gone, subnet_id and the NIC's inputs are new), configures its provider and needs Terraform >= 1.16 and the registry; admin_password is required. Use it as a template, not as a building block.

### Features

* **windows-vm:** a template of its own, with its network interface and import ([44d3271](https://github.com/Opsolete/terraform-modules-examples/commit/44d32718466b8757239cb0c654f95ea56054a6bd))

## [1.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/data-disk-v1.0.0...data-disk-v1.1.0) (2026-11-10)


### Features

* **data-disk:** import an existing disk with existing = true; resources named main ([471e44b](https://github.com/Opsolete/terraform-modules-examples/commit/471e44b4a4ea56393f640ec9888c99ebe4e469c2))

## [1.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/data-disk-v0.1.0...data-disk-v1.0.0) (2026-11-10)


### Documentation

* a README per building block ([87cd001](https://github.com/Opsolete/terraform-modules-examples/commit/87cd0015a1044cda25323af1ac0aceb046025dff))

## 0.1.0 (2026-11-10)


### Features

* **data-disk:** an empty managed disk attached to a VM at a LUN ([cc2e36d](https://github.com/Opsolete/terraform-modules-examples/commit/cc2e36da716ccdbf0f4ad9756a3904e4949138ec))
