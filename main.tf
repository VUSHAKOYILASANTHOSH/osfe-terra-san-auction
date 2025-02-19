provider "azurerm" {
  features {}
  
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account for Function App
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan (Consumption Plan)
resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location
  os_type            = "Linux"
  sku_name           = "Y1"  # Consumption plan
}

# Azure Function App
resource "azurerm_linux_function_app" "function" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location           = azurerm_resource_group.rg.location

  service_plan_id   = azurerm_service_plan.plan.id
  storage_account_name = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key

  site_config {
    application_stack {
      python_version = "3.8"  # Change for your runtime (dotnet, node, java)
    }
  }
}
