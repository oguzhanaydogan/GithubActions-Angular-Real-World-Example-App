terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.37.0"
    }
  }
}

provider "azurerm" {
  features {
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_service_plan" "service_plan" {
  name                = var.service_plan_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = "Linux"
  sku_name = "F1"
}

resource "azurerm_linux_web_app" "linux_webapp" {
  name                = var.webapp_name
  resource_group_name = var.rg_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.service_plan.id

   site_config {
    always_on      = false

    application_stack {
      docker_image     = "tetris"
      docker_image_tag = "latest"
  }
}
}