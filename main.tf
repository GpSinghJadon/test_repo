provider "azurerm" {
  
  version = "=2.20.0"
  subscription_id = "6d5ae732-b526-4f92-a94b-e7f460d3733a"
  client_id       = "935fb058-e6e1-4d48-9e21-47380b15b951"
  client_secret   = "3B51T_5j~40YpOd.rIrZg6~sdzX~dP.8VA"
  tenant_id       = "b066b0b3-57a6-451f-9111-12a529a39311"
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "azure-functions-test-rg"
  location = "westus2"
}

resource "azurerm_storage_account" "example" {
  name                     = "functionsapptestsa123456"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "example" {
  name                = "azure-functions-test-service-plan1234"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_function_app" "example" {
  name                      = "test-azure-functions-for-pradeep-demo"
  location                  = azurerm_resource_group.example.location
  resource_group_name       = azurerm_resource_group.example.name
  app_service_plan_id       = azurerm_app_service_plan.example.id
  storage_connection_string = azurerm_storage_account.example.primary_connection_string
}
