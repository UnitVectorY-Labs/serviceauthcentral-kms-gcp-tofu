[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![Work In Progress](https://img.shields.io/badge/Status-Work%20In%20Progress-yellow)](https://unitvectory-labs.github.io/uvy-labs-guide/bestpractices/status/#work-in-progress)

# serviceauthcentral-kms-gcp-tofu

OpenTofu module for deploying ServiceAuthCentral KMS Keys

## Usage

```hcl
module "serviceauthcentral_kms_gcp" {
    source = "git::https://github.com/UnitVectorY-Labs/serviceauthcentral-kms-gcp-tofu.git?ref=main"
    name = "serviceauthcentral"
    project_id = var.project_id
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_kms_crypto_key.asymmetric_sign_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_key_ring.sign_key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_project_service.kms](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_kms_crypto_key.existing_crypto_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_crypto_key) | data source |
| [google_kms_key_ring.existing_key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/kms_key_ring) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_kms_existing_key"></a> [kms\_existing\_key](#input\_kms\_existing\_key) | Boolean value indicating if an existing KMS key should be used | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the application | `string` | `"serviceauthcentral"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The GCP project id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_name"></a> [key\_name](#output\_key\_name) | The name of the key. |
| <a name="output_key_ring_name"></a> [key\_ring\_name](#output\_key\_ring\_name) | The name of the key ring. |
<!-- END_TF_DOCS -->
