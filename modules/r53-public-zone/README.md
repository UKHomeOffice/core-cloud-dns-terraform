<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_zone.workload_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the Route 53 hosted zone | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the hosted zone is deployed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be applied to the hosted zone | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | List of name servers for delegation |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The ID of the Route 53 hosted zone |
<!-- END_TF_DOCS -->