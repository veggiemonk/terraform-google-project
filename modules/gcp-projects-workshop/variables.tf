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
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "cloudshell.googleapis.com", # Cloud Shell API
    "compute.googleapis.com", # Compute Engine API
    "container.googleapis.com", # Kubernetes Engine API
    "containerregistry.googleapis.com", # Container Registry API
    "iam.googleapis.com", # Identity and Access Management (IAM) API
    "logging.googleapis.com", # Stackdriver Logging API
    "oslogin.googleapis.com", # Cloud OS Login API
    "replicapool.googleapis.com", # Compute Engine Instance Group Manager API
    "replicapoolupdater.googleapis.com", # Compute Engine Instance Group Updater API
    "resourceviews.googleapis.com", # Compute Engine Instance Groups API
    "storage-api.googleapis.com", # Google Cloud Storage JSON API
    "storage-component.googleapis.com", # Cloud Storage
  ]
}
