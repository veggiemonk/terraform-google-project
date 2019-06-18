# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------
variable "org_id" {
  type        = string
  default     = ""
  description = <<EOF
The organization to hold the newly created project.
This variable can be empty if `project_id` is set.
EOF
}

variable "billing_account" {
  type = string
  default = ""
  description = <<EOF
The billing_account ID to attach to the project for attributing costs.
This variable can be empty if `project_id` is set.
EOF
}

variable "project_prefix" {
  type        = string
  default     = ""
  description = <<EOF
The prefix for the project to be created. 
All GCP projects must be globally unique so a random string 
will be added to this prefix if used.
This variable can be empty if `project_id` is set.
EOF
}

# Or set one

variable "project_id" {
  type = string
  default = ""
  description = <<EOF
The id of the already existing project in which to set the owners and editors.
If not specified, the variables `project_prefix`, `org_id` and `billing_account`
must be set.
EOF
}

#------------------------------------------------------------------------------
# SERVICE ACCOUNT
#------------------------------------------------------------------------------
variable "service_account_name" {
  description = <<EOF
Displayed name of the service account.

Example: "App server"
EOF
}

variable "service_account_id" {
  description = <<EOF
ID of the service account. It must match regexp "^[a-z](?:[-a-z0-9]{4,28}[a-z0-9])$"
Meaning: between 4 to 28 characters, containing numbers,letters and dashes `-`.

Example: "app-server"
EOF
}

#------------------------------------------------------------------------------
# IAM ROLES
#------------------------------------------------------------------------------
variable "service_account_iam_roles" {
  type = list(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
  ]

  description = <<EOF
List of the default IAM roles to attach to the service account on.
EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# These parameters have reasonable defaults.
# ---------------------------------------------------------------------------------------------------------------------
variable "services" {
  description = "See the full list of API that can be activate with `gcloud services list --available`"

  type = list(string)
  default = [
    "cloudresourcemanager.googleapis.com", # Cloud Resource Manager API
    "cloudshell.googleapis.com", # Cloud Shell API
    "compute.googleapis.com", # Compute Engine API
    "container.googleapis.com", # Kubernetes Engine API
    "containerregistry.googleapis.com", # Container Registry API
    "iam.googleapis.com", # Identity and Access Management (IAM) API
    "cloudkms.googleapis.com", # Cloud Key Management Service (KMS) API
    "logging.googleapis.com", # Stackdriver Logging API
    "oslogin.googleapis.com", # Cloud OS Login API
    "replicapool.googleapis.com", # Compute Engine Instance Group Manager API
    "replicapoolupdater.googleapis.com", # Compute Engine Instance Group Updater API
    "resourceviews.googleapis.com", # Compute Engine Instance Groups API
    "storage-api.googleapis.com", # Google Cloud Storage JSON API
    "storage-component.googleapis.com", # Cloud Storage
  ]
}

#------------------------------------------------------------------------------
# IAM ROLES
#------------------------------------------------------------------------------
variable "service_account_custom_iam_roles" {
type = list(string)
default = []

description = <<EOF
List of arbitrary additional IAM roles to attach to the service account.
They will be attached to the same service account but allows for further customization.
EOF

}
