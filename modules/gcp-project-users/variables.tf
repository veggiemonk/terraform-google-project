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

variable "region" {
  type    = string
  default = "europe-west1"
}

variable "project_prefix" {
  description = "The prefix for the project to be created. All GCP projects must be globally unique so a random string will be added to this prefix if used. "
  default     = ""
}

variable "project_id" {
  description = "The id of the already existing project in which to set the owners and editors."
  type        = string
  default     = ""
}

#------------------------------------------------------------------------------
# ACTIVATE APIS
#------------------------------------------------------------------------------

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

#------------------------------------------------------------------------------
# OWNERS & EDITORS
#------------------------------------------------------------------------------

variable "owners" {
  type = list(string)
  description = <<EOF
The list of the user account that will receive the `owner` role in the project.

Be careful! 
You can accidentally lock yourself out of your project using this resource. 
See https://www.terraform.io/docs/providers/google/r/google_project_iam.html
EOF
  default = ["owner@gmail.com"]
}

variable "editors" {
  type = list(string)
  
  description = <<EOF
The list of the user account that will receive the `editor` role in the project.
Be careful! 
You can accidentally lock yourself out of your project using this resource. 
See https://www.terraform.io/docs/providers/google/r/google_project_iam.html

EOF
  # TODO: Use "group" instead of "user"
  default = [
    "editor1@gmail.com",
    "editor2@gmail.com",
    "editor3@gmail.com",
  ]
}
