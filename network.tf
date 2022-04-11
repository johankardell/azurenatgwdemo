resource "azurerm_virtual_network" "vnet" {
  address_space       = ["192.168.0.0/23"]
  location            = azurerm_resource_group.rg.location
  name                = "vnet-bastion-demo"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "iaas" {
  name                 = "iaas"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.0.0/24"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["192.168.1.0/24"]
}


resource "azurerm_virtual_network" "vnet2" {
  address_space       = ["172.16.0.0/23"]
  location            = azurerm_resource_group.rg.location
  name                = "vnet-peering-demo"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "iaas2" {
  name                 = "iaas2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["172.16.0.0/24"]
}

resource "azurerm_virtual_network_peering" "vnetvnet2" {
  name                      = "vnetvnet2"
  remote_virtual_network_id = azurerm_virtual_network.vnet2.id
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
}

resource "azurerm_virtual_network_peering" "vnet2vnet" {
  name                      = "vnet2vnet"
  remote_virtual_network_id = azurerm_virtual_network.vnet.id
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet2.name
}
