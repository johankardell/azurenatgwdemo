resource "azurerm_public_ip" "natgw" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.rg.location
  name                = "pip-natgw"
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "natgw" {
  location            = azurerm_resource_group.rg.location
  name                = "natgw-demo"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_nat_gateway_association" "natgwiaas" {
  subnet_id      = azurerm_subnet.iaas.id
  nat_gateway_id = azurerm_nat_gateway.natgw.id
}

// Still doesn't support subnets from multiple vnets: NatGatewayCannotBeUsedBySubnetsBelongingToDifferentVirtualNetworks
# resource "azurerm_subnet_nat_gateway_association" "natgwiaas2" {
#   subnet_id      = azurerm_subnet.iaas2.id
#   nat_gateway_id = azurerm_nat_gateway.natgw.id
# }

resource "azurerm_nat_gateway_public_ip_association" "natgwpip" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw.id
}
