# Changelog

## [2.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/network-security-group-v1.1.0...network-security-group-v2.0.0) (2026-11-11)


### ⚠ BREAKING CHANGES

* **windows-vm:** windows-vm creates its own network interface (network_interface_id is gone, subnet_id and the NIC's inputs are new), configures its provider and needs Terraform >= 1.16 and the registry; admin_password is required. Use it as a template, not as a building block.

### Features

* **windows-vm:** a template of its own, with its network interface and import ([44d3271](https://github.com/Opsolete/terraform-modules-examples/commit/44d32718466b8757239cb0c654f95ea56054a6bd))

## [1.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/network-security-group-v1.0.0...network-security-group-v1.1.0) (2026-11-10)


### Features

* **network-security-group:** import an existing group with existing = true; resources named main ([471603e](https://github.com/Opsolete/terraform-modules-examples/commit/471603ea6e07305a95d4778bc8e91b8739fac1f4))

## 1.0.0 (2026-11-10)


### Features

* **network-security-group:** a network security group with its rules, on a network interface ([6ca4ab5](https://github.com/Opsolete/terraform-modules-examples/commit/6ca4ab5c5738c52bce65769f27ced398fcba448b))


### Documentation

* a README per building block ([87cd001](https://github.com/Opsolete/terraform-modules-examples/commit/87cd0015a1044cda25323af1ac0aceb046025dff))
