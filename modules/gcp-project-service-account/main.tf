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
  services = var.services

  # Do not disable the service on destroy. On destroy, we are going to
  # destroy the project, but we need the APIs available to destroy the
  # underlying resources.
  disable_on_destroy = false
}

#------------------------------------------------------------------------------
# Create the app service account and key
#------------------------------------------------------------------------------
resource "google_service_account" "app" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
  project      = local.project_id
}

resource "google_service_account_key" "app" {
  service_account_id = google_service_account.app.name
}

# Add the service account to the project
resource "google_project_iam_member" "service-account" {
  count   = length(var.service_account_iam_roles)
  project = local.project_id
  role    = element(var.service_account_iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.app.email}"
}

# Add user-specified roles
resource "google_project_iam_member" "service-account-custom" {
  count   = length(var.service_account_custom_iam_roles)
  project = local.project_id
  role    = element(var.service_account_custom_iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.app.email}"
}

