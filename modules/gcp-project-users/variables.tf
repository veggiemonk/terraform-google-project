# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These parameters must be supplied when consuming this module.
# ---------------------------------------------------------------------------------------------------------------------
variable "org_id" {
  description = <<EOF
The organization to hold the newly created project.
This variable can be empty if `project_id` is set.
EOF

  type = string
  default = ""
}

variable "billing_account" {
  description = <<EOF
The billing_account ID to attach to the project for attributing costs.
This variable can be empty if `project_id` is set.
EOF

  type    = string
  default = ""
}

variable "project_prefix" {
  description = <<EOF
The prefix for the project to be created.
All GCP projects must be globally unique so a random string
will be added to this prefix if used.
This variable can be empty if `project_id` is set.
EOF

  type = string
  default = ""
}

# Or set one

variable "project_id" {
  description = <<EOF
The id of the already existing project in which to set the owners and editors.
If not specified, the variables `project_prefix`, `org_id` and `billing_account`
must be set.
EOF

  type    = string
  default = ""
}

#------------------------------------------------------------------------------
# OWNERS & EDITORS
#------------------------------------------------------------------------------
variable "owners" {
  type    = list(string)
  default = []

  description = <<EOF
The list of the user account that will receive the `owner` role in the project.
Example: ["owner@gmail.com"]
Be careful!
You can accidentally lock yourself out of your project using this resource.
See https://www.terraform.io/docs/providers/google/r/google_project_iam.html
EOF
}

variable "editors" {
  type = list(string)
  # TODO: Use "group" instead of "user"
  default = []

  description = <<EOF
The list of the user account that will receive the `editor` role in the project.
Example:
[
  "editor1@gmail.com",
  "editor2@gmail.com",
  "editor3@gmail.com",
]
Be careful!
You can accidentally lock yourself out of your project using this resource.
See https://www.terraform.io/docs/providers/google/r/google_project_iam.html
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