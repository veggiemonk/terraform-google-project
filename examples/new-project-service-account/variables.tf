variable "billing_account" {
}
variable "org_id" {
}

variable "name_prefix" {
  default = "my-app"
}

variable "region" {
  default = "europe-west1"
}

variable "service_account_iam_roles" {
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
  ]
}

variable "services" {
  description = "Manually enabled APIs will be removed if not added here"
  default = [
    "bigquery-json.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudshell.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "deploymentmanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "logging.googleapis.com",
    "oslogin.googleapis.com",
    "pubsub.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
  ]
}

