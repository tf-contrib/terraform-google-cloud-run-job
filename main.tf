resource "google_cloud_run_v2_job" "job" {
  name         = var.name
  project      = var.project_id
  location     = var.location
  launch_stage = var.launch_stage
  labels       = var.labels

  template {
    labels      = var.labels
    parallelism = var.parallelism
    task_count  = var.task_count

    template {
      max_retries     = var.max_retries
      service_account = var.service_account_email
      timeout         = var.timeout

      containers {
        image   = var.image
        command = var.container_command
        args    = var.argument

        resources {
          limits = var.limits
        }

        dynamic "env" {
          for_each = var.env_vars
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }

        dynamic "env" {
          for_each = var.env_secret_vars
          content {
            name = env.value["name"]
            dynamic "value_source" {
              for_each = env.value.value_source
              content {
                secret_key_ref {
                  secret  = value_source.value.secret_key_ref["secret"]
                  version = value_source.value.secret_key_ref["version"]
                }
              }
            }
          }
        }

        dynamic "volume_mounts" {
          for_each = var.volume_mounts
          content {
            name       = volume_mounts.value["name"]
            mount_path = volume_mounts.value["mount_path"]
          }
        }
      }

      dynamic "volumes" {
        for_each = var.volumes
        content {
          name = volumes.value["name"]
          cloud_sql_instance {
            instances = volumes.value.cloud_sql_instance["instances"]
          }
        }
      }

      dynamic "vpc_access" {
        for_each = var.vpc_access
        content {
          connector = vpc_access.value["connector"]
          egress    = vpc_access.value["egress"]
        }
      }
    }
  }
}

data "google_client_config" "default" {}

data "http" "exec" {
  count = var.exec ? 1 : 0

  url    = "https://run.googleapis.com/v2/${google_cloud_run_v2_job.job.id}:run"
  method = "POST"

  request_headers = {
    "Authorization" = "Bearer ${data.google_client_config.default.access_token}"
    "Content-Type"  = "application/json"
  }

  retry {
    attempts     = 1
    min_delay_ms = 3000
  }

  lifecycle {
    postcondition {
      condition     = self.status_code == 200
      error_message = "Bootstrap execution was rejected"
    }
  }
}
