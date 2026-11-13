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

variable "subnet_id" {
  type        = string
  description = "ID of the subnet the private endpoint gets its IP address in."
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
