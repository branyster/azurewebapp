## <https://www.terraform.io/docs/providers/azurerm/index.html>
terraform {
  required_version = "~> 1.0"
  backend "azurerm" {
    resource_group_name  = "NicholasBranson-Sandbox-RG-EUW"
    storage_account_name = "nicholasbransonsanda680"
    container_name       = "tfstate"
    key                  = "sandbox.terraform.tfstate"
    access_key           = "9PKCXf66ZINBN0dHVzB/mEiSllVRseJNIdQfuo9X54vp87BA/w4YOOo0SmZimRbMKWn0PLeZYWsl+AStTnMDWQ=="
    subscription_id      = "e5f965df-48b2-4fea-b59d-1dd78281a9c2"
    tenant_id            = "f009f285-5242-433a-9365-daa1edf145c3"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.45.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.35.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

provider "azuread" {
}