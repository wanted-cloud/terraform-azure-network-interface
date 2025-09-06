/*
 * # wanted-cloud/terraform-azure-network-interface
 * 
 * Terraform building block managing Azure Network Interface and its related resources.
 */

resource "azurerm_network_interface" "this" {
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name

  auxiliary_mode = var.auxiliary_mode
  auxiliary_sku  = var.auxiliary_sku
  dns_servers    = var.dns_servers

  edge_zone                      = var.edge_zone != "" ? var.edge_zone : null
  ip_forwarding_enabled          = var.ip_forwarding_enabled
  accelerated_networking_enabled = var.accelerated_networking_enabled
  internal_dns_name_label        = var.internal_dns_name_label != "" ? var.internal_dns_name_label : null

  tags = merge(local.metadata.tags, var.tags)

  dynamic "ip_configuration" {
    for_each = var.ip_configurations

    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      private_ip_address            = ip_configuration.value.private_ip_address
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      primary                       = ip_configuration.value.primary
    }
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_network_interface"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_network_interface"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_network_interface"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_network_interface"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}