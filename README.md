<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-network-interface

Terraform building block managing Azure Network Interface and its related resources.

## Table of contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Variables](#inputs)
- [Outputs](#outputs)
- [Resources](#resources)
- [Usage](#usage)
- [Contributing](#contributing)

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>=4.20.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>=4.20.0)

## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: Name of the Azure network interface resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Name of the resource group in which the Azure network interface will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_accelerated_networking_enabled"></a> [accelerated\_networking\_enabled](#input\_accelerated\_networking\_enabled)

Description: Enable accelerated networking for the Azure network interface.

Type: `bool`

Default: `false`

### <a name="input_auxiliary_mode"></a> [auxiliary\_mode](#input\_auxiliary\_mode)

Description: Auxiliary mode for the Azure network interface.

Type: `string`

Default: `"None"`

### <a name="input_auxiliary_sku"></a> [auxiliary\_sku](#input\_auxiliary\_sku)

Description: Auxiliary SKU for the Azure network interface.

Type: `string`

Default: `"None"`

### <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers)

Description: DNS servers for the Azure network interface.

Type: `list(string)`

Default: `[]`

### <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone)

Description: Edge zone for the Azure network interface.

Type: `string`

Default: `""`

### <a name="input_internal_dns_name_label"></a> [internal\_dns\_name\_label](#input\_internal\_dns\_name\_label)

Description: Internal DNS name label for the Azure network interface.

Type: `string`

Default: `""`

### <a name="input_ip_configurations"></a> [ip\_configurations](#input\_ip\_configurations)

Description: IP configurations for the Azure network interface.

Type:

```hcl
list(object({
    name                                               = string
    subnet_id                                          = optional(string, "")
    gateway_load_balancer_frontend_ip_configuration_id = optional(string, "")
    private_ip_address_allocation                      = optional(string, "Dynamic")
    private_ip_address_version                         = optional(string, "IPv4")
    private_ip_address                                 = optional(string, "")
    public_ip_address_id                               = optional(string, "")
    primary                                            = optional(bool, false)
  }))
```

Default: `[]`

### <a name="input_ip_forwarding_enabled"></a> [ip\_forwarding\_enabled](#input\_ip\_forwarding\_enabled)

Description: Enable IP forwarding for the Azure network interface.

Type: `bool`

Default: `false`

### <a name="input_location"></a> [location](#input\_location)

Description: Location of the resource group in which the Azure network interface will be created, if not set it will be the same as the resource group.

Type: `string`

Default: `""`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Metadata definitions for the module, this is optional construct allowing override of the module defaults defintions of validation expressions, error messages, resource timeouts and default tags.

Type:

```hcl
object({
    resource_timeouts = optional(
      map(
        object({
          create = optional(string, "30m")
          read   = optional(string, "5m")
          update = optional(string, "30m")
          delete = optional(string, "30m")
        })
      ), {}
    )
    tags                     = optional(map(string), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Tags to be applied to the Azure network interface.

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_network_interface"></a> [network\_interface](#output\_network\_interface)

Description: n/a

## Resources

The following resources are used by this module:

- [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

## Usage

> For more detailed examples navigate to `examples` folder of this repository.

Module was also published via Terraform Registry and can be used as a module from the registry.

```hcl
module "example" {
  source  = "wanted-cloud/..."
  version = "x.y.z"
}
```

### Basic usage example

The minimal usage for the module is as follows:

```hcl
module "template" {
    source = "../.."
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->