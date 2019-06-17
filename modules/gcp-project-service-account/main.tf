#------------------------------------------------------------------------------
# GOOGLE PROVIDER
#------------------------------------------------------------------------------

provider "google" {
  region  = var.region
  project = var.project_id
}

provider "google-beta" {
  region  = var.region
  project = var.project_id
}

#------------------------------------------------------------------------------
# CREATE OR REUSE GCP PROJECT
#------------------------------------------------------------------------------

# Generate a random id for the project - GCP projects must have globally
# unique names
resource "random_id" "project_random" {
  prefix      = var.project_prefix
  byte_length = "8"
}

# Create the project if one isn't specified
resource "google_project" "project" {
  count           = var.project_id != "" ? 0 : 1
  name            = random_id.project_random.hex
  project_id      = random_id.project_random.hex
  org_id          = var.org_id
  billing_account = var.billing_account
}

# Or use an existing project, if defined
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
    : data.google_project.project.*.project_id
  )
}

#------------------------------------------------------------------------------
# ACTIVATE APIS
#------------------------------------------------------------------------------

# Activates all the listed API in the GCP project
resource "google_project_services" "apis" {
  project = local.project_id

  services = var.services
}

#------------------------------------------------------------------------------
# SERVICE ACCOUNT
#------------------------------------------------------------------------------

# Create the app service account
resource "google_service_account" "app" {
  account_id   = var.service_account_id
  display_name = var.service_account_name
  project      = local.project_id
}

# Create a service account key
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

