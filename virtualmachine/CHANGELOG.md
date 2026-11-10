# Changelog

## [5.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/virtualmachine-v4.1.0...virtualmachine-v5.0.0) (2026-11-10)


### ⚠ BREAKING CHANGES

* **virtualmachine:** data_disks_json and nsg_rules_json are gone. Set data_disks and nsg_rules before upgrading a VM that has data disks or rules: left empty, the plan removes them.

### Features

* **virtualmachine:** data_disks and nsg_rules are lists of objects ([a51272e](https://github.com/Opsolete/terraform-modules-examples/commit/a51272e1cc3964caa93f529828760c70b00768d0))

## [4.1.0](https://github.com/Opsolete/terraform-modules-examples/compare/virtualmachine-v4.0.0...virtualmachine-v4.1.0) (2026-11-10)


### Features

* **virtualmachine:** existing data disks, auto-shutdown and NSG are imported ([de146d7](https://github.com/Opsolete/terraform-modules-examples/commit/de146d7c47bf2df5937d966c331ac6ba096cf2fe))

## [4.0.0](https://github.com/Opsolete/terraform-modules-examples/compare/virtualmachine-v3.2.0...virtualmachine-v4.0.0) (2026-11-10)


### ⚠ BREAKING CHANGES

* **virtualmachine:** Terraform must reach the registry to fetch the building blocks (a registry token for the host where Opsolete runs the module).

### Features

* **virtualmachine:** compose the building blocks from the registry ([8f872de](https://github.com/Opsolete/terraform-modules-examples/commit/8f872de3de6663b391d0cc6c069de9154835d41b))
