terraform {
  # The modules used in this example have been updated with 0.12 syntax, which means the example is no longer
  # compatible with any versions below 0.12.
  required_version = ">= 0.12"
}

#------------------------------------------------------------------------------
# Creates one GCP project per trainee
#------------------------------------------------------------------------------
resource "random_id" "trainee" {
  count       = length(var.emails_editor)
  byte_length = "4"
}

resource "google_project" "trainee" {
  count           = length(var.emails_editor)
  name            = "${var.project_prefix}-${element(random_id.trainee.*.hex, count.index)}"
  project_id      = "${var.project_prefix}-${element(random_id.trainee.*.hex, count.index)}"
  billing_account = var.billing_account
  org_id          = var.org_id
}

#------------------------------------------------------------------------------
# Activates the service APIs
#------------------------------------------------------------------------------
resource "google_project_services" "trainee" {
  count   = length(var.emails_editor)
  project = element(google_project.trainee.*.project_id, count.index)

  services = var.services
}

#------------------------------------------------------------------------------
# Set IAM permissions
#------------------------------------------------------------------------------
data "google_iam_policy" "trainee" {
  count = length(var.emails_editor)

  binding {
    role = "roles/owner"

    members = [
      "user:${var.email_owner}",
    ]
  }

  binding {
    role = "roles/editor"

    members = [
      "user:${element(var.emails_editor, count.index)}",
    ]
  }
}

resource "google_project_iam_policy" "trainee" {
  count       = length(var.emails_editor)
  project     = element(google_project.trainee.*.project_id, count.index)
  policy_data = element(data.google_iam_policy.trainee.*.policy_data, count.index)
}

