# ---------------------------------------------------------------------------------------------------------------------
# PREPARE PROVIDERS
# ---------------------------------------------------------------------------------------------------------------------

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "project" {
  source = "../../modules/gcp-project-service-account"
  //  source = "github.com/veggiemonk/terraform-google-project//modules/gcp-project-service-account"

  project_id                = var.project_id
  service_account_name      = "${var.name_prefix} Server"
  service_account_id        = "${var.name_prefix}-server"
  service_account_iam_roles = var.service_account_iam_roles

  # Will be replaced at every apply!
  services = var.services
}


