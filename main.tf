resource "azurerm_resource_group" "rg" {
  location = local.location
  name     = "natgw-demo"
}

data "azurerm_client_config" "current" {}
