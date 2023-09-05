###########################################
# Consumption ASP for Function Apps
###########################################
resource "azurerm_service_plan" "test_shared_asp" {
  name                = "Test-Cons-ASP"
  resource_group_name = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.name
  location            = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.location
  os_type             = "Windows"
  sku_name            = var.CONS_FUNC_PLAN_SKU
}

###########################################
# Consumption Function App
###########################################
resource "azurerm_windows_function_app" "imageprocessor" {
  name                       = "Test-Cons-FuncApp"
  resource_group_name        = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.name
  location                   = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.location
  storage_account_name       = data.azurerm_storage_account.nick.name
  storage_account_access_key = data.azurerm_storage_account.nick.primary_access_key
  service_plan_id            = azurerm_service_plan.test_shared_asp.id

  site_config {}
}

#######################################
# Storage account used by Function App
#######################################
resource "azurerm_storage_account" "cons_reciever" {
  name                          = "consrecstorageacc"
  resource_group_name           = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.name
  location                      = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true
}

#######################################
# Deployment slot used by Function App
#######################################

## Seeing 'The remote server returned an error: (403) Forbidden' error for this step in the code ##

resource "azurerm_windows_function_app_slot" "func_app" {
  name                 = "imageprocessor-slot"
  function_app_id      = azurerm_windows_function_app.imageprocessor.id
  storage_account_name = azurerm_storage_account.cons_reciever.name

  site_config {}
}