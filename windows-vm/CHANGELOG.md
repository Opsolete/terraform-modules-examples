# Changelog

## [2.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/windows-vm-v1.1.0...windows-vm-v2.0.0) (2026-11-11)


### ⚠ BREAKING CHANGES

* **windows-vm:** windows-vm creates its own network interface (network_interface_id is gone, subnet_id and the NIC's inputs are new), configures its provider and needs Terraform >= 1.16 and the registry; admin_password is required. Use it as a template, not as a building block.

### Features

* **windows-vm:** a template of its own, with its network interface and import ([44d3271](https://github.com/Opsolete/terraform-modules-examples/commit/44d32718466b8757239cb0c654f95ea56054a6bd))

## [1.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/windows-vm-v1.0.0...windows-vm-v1.1.0) (2026-11-10)


### Features

* **windows-vm:** resource named main, moved from its old name ([11846e6](https://github.com/Opsolete/terraform-modules-examples/commit/11846e6254b23a2ec651dc32788bf7a7b571c0a2))

## 1.0.0 (2026-11-10)


### Features

* **windows-vm:** a Windows VM on a given network interface ([f983a4d](https://github.com/Opsolete/terraform-modules-examples/commit/f983a4df2e0dfdfe6038383c02523f409102150a))


### Documentation

* a README per building block ([87cd001](https://github.com/Opsolete/terraform-modules-examples/commit/87cd0015a1044cda25323af1ac0aceb046025dff))
