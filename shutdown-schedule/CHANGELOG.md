# Changelog

## [2.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/shutdown-schedule-v1.1.0...shutdown-schedule-v2.0.0) (2026-11-11)


### ⚠ BREAKING CHANGES

* **windows-vm:** windows-vm creates its own network interface (network_interface_id is gone, subnet_id and the NIC's inputs are new), configures its provider and needs Terraform >= 1.16 and the registry; admin_password is required. Use it as a template, not as a building block.

### Features

* **windows-vm:** a template of its own, with its network interface and import ([44d3271](https://github.com/Opsolete/terraform-modules-examples/commit/44d32718466b8757239cb0c654f95ea56054a6bd))

## [1.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/shutdown-schedule-v1.0.0...shutdown-schedule-v1.1.0) (2026-11-10)


### Features

* **shutdown-schedule:** import an existing schedule with existing = true; resource named main ([003bea2](https://github.com/Opsolete/terraform-modules-examples/commit/003bea270107f847ee4dd6867742a52fd2b53ec8))

## 1.0.0 (2026-11-10)


### Features

* **shutdown-schedule:** a VM's daily auto-shutdown, optionally with an email before it ([79cdeda](https://github.com/Opsolete/terraform-modules-examples/commit/79cdedaf8030cfe890218746aa7c722a751288eb))


### Documentation

* a README per building block ([87cd001](https://github.com/Opsolete/terraform-modules-examples/commit/87cd0015a1044cda25323af1ac0aceb046025dff))
