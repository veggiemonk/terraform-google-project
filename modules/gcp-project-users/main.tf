terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

#------------------------------------------------------------------------------
# Create the project or use an existing project, if defined
#------------------------------------------------------------------------------

# Generate a random id for the project - GCP projects must have globally
# unique names
resource "random_id" "project_random" {
  prefix      = var.project_prefix
  byte_length = "8"
}

resource "google_project" "project" {
  count           = var.project_id != "" ? 0 : 1
  name            = random_id.project_random.hex
  project_id      = random_id.project_random.hex
  org_id          = var.org_id
  billing_account = var.billing_account
}

data "google_project" "project" {
  count      = var.project_id != "" ? 1 : 0
  project_id = var.project_id
}

# Obtain the project_id from either the newly created project resource or
# existing data project resource
locals {
  project_id = trimspace(
    google_project.project[0].project_id != ""
    ? google_project.project[0].project_id
    : data.google_project.project[0].project_id
  )
}

#------------------------------------------------------------------------------
# Activates all the listed API in the GCP project
#------------------------------------------------------------------------------
resource "google_project_services" "apis" {
  project = local.project_id

  services = var.services
}

#------------------------------------------------------------------------------
# OWNERS & EDITORS
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
#     WARNING !!!
#
# You can accidentally lock yourself out of your project using this resource. 
# Deleting a google_project_iam_policy removes access from anyone without 
# organization-level access to the project. 
# Proceed with caution. 
#
# It's not recommended to use google_project_iam_policy with your provider project 
# to avoid locking yourself out, 
# and it should generally only be used with projects fully managed by Terraform.
# see https://www.terraform.io/docs/providers/google/r/google_project_iam.html
#
#------------------------------------------------------------------------------

# Adds the owners for the project
data "google_iam_policy" "owners" {
  count = length(var.owners)

  binding {
    role = "roles/owner"

    members = [
      "user:${element(var.owners, count.index)}",
    ]
  }
}
# Sets the IAM policy for the project and replaces any existing policy already attached.
resource "google_project_iam_policy" "owners" {
  count       = length(var.owners)
  project     = local.project_id
  policy_data = element(data.google_iam_policy.owners.*.policy_data, count.index)
}

# Adds the editors for the project
data "google_iam_policy" "editors" {
  count = length(var.editors)

  binding {
    role = "roles/editor"

    members = [
      "user:${element(var.editors, count.index)}",
    ]
  }
}
# Sets the IAM policy for the project and replaces any existing policy already attached.
resource "google_project_iam_policy" "editors" {
  count       = length(var.editors)
  project     = local.project_id
  policy_data = element(data.google_iam_policy.editors.*.policy_data, count.index)
}

