variable "name" {
  type        = string
  description = "VM name: 1-64 letters, digits or -, not starting or ending with -."

  validation {
    condition     = can(regex("^[A-Za-z0-9]([A-Za-z0-9-]{0,62}[A-Za-z0-9])?$", var.name))
    error_message = "1-64 letters, digits or -, not starting or ending with -."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group, e.g. the name output of the resourcegroup module."
}

variable "location" {
  type        = string
  description = "Azure region, e.g. westeurope. Must match the subnet's region."
  default     = "westeurope"
}

variable "subnet_id" {
  type        = string
  description = "ID of an existing subnet for the VM's network interface."
}

variable "size" {
  type        = string
  description = "VM size, e.g. Standard_B2s."
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Admin user. Azure rejects reserved names like admin or root."
  default     = "azureuser"
}

variable "os_type" {
  type        = string
  description = "windows or linux."
  default     = "windows"

  validation {
    condition     = contains(["windows", "linux"], var.os_type)
    error_message = "os_type must be windows or linux."
  }
}

variable "admin_password" {
  type        = string
  description = "Admin password, required for Windows (12-123 chars, Azure complexity rules)."
  default     = null
  sensitive   = true
}

variable "ssh_public_key" {
  type        = string
  description = "OpenSSH public key for the admin user, required for Linux (ssh-rsa, 2048 bits or more)."
  default     = null
}
