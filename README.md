<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | < 6 |
| <a name="requirement_terracurl"></a> [terracurl](#requirement\_terracurl) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | < 6 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloud_run_v2_job.job](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_job) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [http_http.exec](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image"></a> [image](#input\_image) | GCR hosted image URL to deploy | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Cloud Run job deployment location | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud Run job to create | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `string` | n/a | yes |
| <a name="input_argument"></a> [argument](#input\_argument) | Arguments passed to the ENTRYPOINT command, include these only if image entrypoint needs arguments | `list(string)` | `[]` | no |
| <a name="input_container_command"></a> [container\_command](#input\_container\_command) | Leave blank to use the ENTRYPOINT command defined in the container image, include these only if image entrypoint should be overwritten | `list(string)` | `[]` | no |
| <a name="input_env_secret_vars"></a> [env\_secret\_vars](#input\_env\_secret\_vars) | Environment variables (Secret Manager) | <pre>list(object({<br>    name = string<br>    value_source = set(object({<br>      secret_key_ref = object({<br>        secret  = string<br>        version = optional(string, "latest")<br>      })<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_env_vars"></a> [env\_vars](#input\_env\_vars) | Environment variables (cleartext) | <pre>list(object({<br>    value = string<br>    name  = string<br>  }))</pre> | `[]` | no |
| <a name="input_exec"></a> [exec](#input\_exec) | Whether to execute job after creation | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Cloud Run job. | `map(string)` | `{}` | no |
| <a name="input_launch_stage"></a> [launch\_stage](#input\_launch\_stage) | The launch stage. (see https://cloud.google.com/products#product-launch-stages). Defaults to GA. | `string` | `""` | no |
| <a name="input_limits"></a> [limits](#input\_limits) | Resource limits to the container | <pre>object({<br>    cpu    = optional(string)<br>    memory = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_max_retries"></a> [max\_retries](#input\_max\_retries) | Number of retries allowed per Task, before marking this Task failed. | `number` | `null` | no |
| <a name="input_parallelism"></a> [parallelism](#input\_parallelism) | Specifies the maximum desired number of tasks the execution should run at given time. Must be <= taskCount. | `number` | `null` | no |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Service Account email needed for the job | `string` | `""` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | Specifies the desired number of tasks the execution should run. | `number` | `null` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Max allowed time duration the Task may be active before the system will actively try to mark it failed and kill associated containers. | `string` | `"600s"` | no |
| <a name="input_volume_mounts"></a> [volume\_mounts](#input\_volume\_mounts) | Volume to mount into the container's filesystem. | <pre>list(object({<br>    name       = string<br>    mount_path = string<br>  }))</pre> | `[]` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A list of Volumes to make available to containers. | <pre>list(object({<br>    name = string<br>    cloud_sql_instance = object({<br>      instances = set(string)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_access"></a> [vpc\_access](#input\_vpc\_access) | VPC Access configuration to use for this Task. | <pre>list(object({<br>    connector = string<br>    egress    = string<br>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Cloud Run Job ID |
<!-- END_TF_DOCS -->