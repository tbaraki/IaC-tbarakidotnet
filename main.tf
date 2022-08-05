terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.16.0"
    }
  }

  cloud {
    organization = "tbaraki"
    workspaces {
      name = "IaC-tbarakidotnet"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "tbarakidotnet" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_static_site" "tbarakidotnet" {
  name                = "tbarakidotnet"
  resource_group_name = azurerm_resource_group.tbarakidotnet.name
  location            = var.location
  sku_tier            = var.sku_tier
}

resource "azurerm_static_site" "tbarakidotnet_resume" {
  name                = "tbarakidotnet-resume"
  resource_group_name = azurerm_resource_group.tbarakidotnet.name
  location            = var.location
  sku_tier            = var.sku_tier
}