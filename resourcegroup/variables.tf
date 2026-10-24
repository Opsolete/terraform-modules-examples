variable "name" {
  type        = string
  description = "Resource group name: 1-90 letters, digits, _ ( ) - or ., not ending in a period."

  validation {
    condition     = can(regex("^[A-Za-z0-9_().-]{0,89}[A-Za-z0-9_()-]$", var.name))
    error_message = "1-90 letters, digits, _ ( ) - or ., not ending in a period."
  }
}

variable "location" {
  type        = string
  description = "Azure region, e.g. westeurope."
}
