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
| [aws_route53_zone.private_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name for the Route 53 private hosted zone | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment in which the hosted zone is deployed | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to be applied to the hosted zone | `map(string)` | `{}` | no |
| <a name="input_vpc_ids"></a> [vpc\_ids](#input\_vpc\_ids) | n/a | `list(string)` | <pre>[<br/>  "vpc-abc123",<br/>  "vpc-def456",<br/>  "vpc-ghi789"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | The ID of the Route 53 private hosted zone |
<!-- END_TF_DOCS -->