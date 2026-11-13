variable "name" {
  type        = string
  description = "Storage account name: 3-24 lowercase letters or digits, unique in Azure."

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "3-24 lowercase letters or digits."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group of the account and its private endpoint (it must exist)."
}

variable "location" {
  type        = string
  description = "Azure region, e.g. westeurope: the subnet's region."
}

variable "replication_type" {
  type        = string
  description = "LRS, ZRS, GRS or RAGRS."
  default     = "LRS"
}

variable "subnet_name" {
  type        = string
  description = "Subnet the private endpoint gets its IP address in, in the subscription's standard virtual network."
}

# The subscription's standard network: the same for every workspace of a project, so a project's variable set
# sets them (terraform variables), not the form.
variable "vnet_name" {
  type        = string
  description = "Virtual network of the subnet."
}

variable "vnet_resource_group_name" {
  type        = string
  description = "Resource group of the virtual network."
}

variable "private_endpoint_name" {
  type        = string
  description = "Name of the private endpoint to the account's blob service."
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "existing" {
  type        = bool
  description = "The account and its private endpoint exist already (made in the portal, say): import them instead of creating them."
  default     = false
}
