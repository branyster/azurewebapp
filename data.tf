data "azurerm_resource_group" "NicholasBranson-Sandbox-RG-EUW" {
  name = "NicholasBranson-Sandbox-RG-EUW"

}

data "azurerm_storage_account" "nick" {
  name                = "nicholasbransonsanda680"
  resource_group_name = data.azurerm_resource_group.NicholasBranson-Sandbox-RG-EUW.name
  
}