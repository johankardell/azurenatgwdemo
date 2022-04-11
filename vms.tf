// vm1 will use natgw
// vm2 will not

module "vm1" {
  source = "./ubuntu"

  subnet_id                 = azurerm_subnet.iaas.id
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  vmname                    = "ubuntu1"
  current_user_principal_id = data.azurerm_client_config.current.object_id
}

module "vm2" {
  source = "./ubuntu"

  subnet_id                 = azurerm_subnet.iaas2.id
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  vmname                    = "ubuntu2"
  current_user_principal_id = data.azurerm_client_config.current.object_id
}
