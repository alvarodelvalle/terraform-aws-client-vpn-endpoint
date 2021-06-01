# terraform-aws-clientvpnendpoint
Terraform module that enables you to securely access your AWS resources

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.40.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.40.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.ca](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_client_vpn_network_association) | resource |
| [tls_cert_request.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.root](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_algorithm"></a> [algorithm](#input\_algorithm) | The name of the algorithm to use for the key. Currently-supported values are "RSA" and "ECDSA". | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR /32 block to associate the client VPN with. | `any` | n/a | yes |
| <a name="input_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | The CloudWatch log group to create | `any` | n/a | yes |
| <a name="input_cloudwatch_log_stream"></a> [cloudwatch\_log\_stream](#input\_cloudwatch\_log\_stream) | The CloudWatch log stream to create | `any` | n/a | yes |
| <a name="input_custom_security_groups"></a> [custom\_security\_groups](#input\_custom\_security\_groups) | A list of up to five custom security groups to apply to the target network. If not specified, the VPC's default security group is assigned. | `list` | `[]` | no |
| <a name="input_ecdsa_curve"></a> [ecdsa\_curve](#input\_ecdsa\_curve) | When algorithm is "ECDSA", the name of the elliptic curve to use. May be any one of "P224", "P256", "P384" or "P521", with "P224" as the default. | `string` | `"P224"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | The organization name to use for the private key | `string` | `"DelvOps"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix to apply to resources | `any` | n/a | yes |
| <a name="input_rsa_bits"></a> [rsa\_bits](#input\_rsa\_bits) | When algorithm is "RSA", the size of the generated RSA key in bits. Defaults to 2048. | `number` | `2048` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The subnet to associate the client VPN with | `any` | n/a | yes |
| <a name="input_validity_period_hours"></a> [validity\_period\_hours](#input\_validity\_period\_hours) | The number of hours after initial issuing that the certificate will become invalid. Default is 87600 (10 years). | `number` | `87600` | no |

## Outputs

No outputs.
