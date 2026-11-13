terraform {
  required_version = ">= 1.16.1" # import blocks in a module: older versions ignore them and create instead
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9" # data_plane_available
    }
  }
}

# Opsolete runs a template as the root module, so the module configures its provider.
# Credentials come from ARM_* env variables (a workspace variable set), never from inputs.
provider "azurerm" {
  features {
    storage {
      # public access is off: the account is only reached through its private endpoint, and the runner
      # isn't in that network, so the provider must stay on the management plane
      data_plane_available = false
    }
  }
}
