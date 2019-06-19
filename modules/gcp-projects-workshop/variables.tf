# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------
variable "org_id" {
  description = "The organization to hold the newly created project."
  type        = string
  default     = ""
}

variable "billing_account" {
  description = "The billing_account ID to attach to the project for attributing costs."
  type        = string
  default     = ""
}

variable "project_prefix" {
  description = "All GCP projects must be globally unique so a random string will be added to this prefix if used. "
  default     = "trainee"
}

variable "email_owner" {
  description = "The account (email) of the trainor"
  default     = "trainer@gmail.com"
}

variable "emails_editor" {
  description = "List of the accounts of the trainees"
  type        = list(string)

  default = [
    "trainee1@gmail.com",
    "trainee2@gmail.com",
    "trainee3@gmail.com",
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "services" {
  type        = list(string)
  description = <<EOF
See the full list of API that can be activate with `gcloud services list` .
EOF
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
