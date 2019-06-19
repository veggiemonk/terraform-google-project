variable "region" {
  default = "europe-west1"
}

variable "billing_account" {
  default = ""
}

variable "org_id" {
  default = ""
}

variable "email_owner" {
  description = "The account (email) of the trainor"
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

