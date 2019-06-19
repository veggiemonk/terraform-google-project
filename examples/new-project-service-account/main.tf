provider "google" {
  region = var.region
}

provider "google-beta" {
  region = var.region
}


module "project" {
  source = "../../modules/gcp-project-service-account"
  //  source = "github.com/veggiemonk/terraform-google-project//modules/gcp-project-service-account"

  billing_account = var.billing_account
  org_id          = var.org_id
  project_prefix  = var.name_prefix

  service_account_name = "${var.name_prefix} Server"
  service_account_id   = "${var.name_prefix}-server"

  service_account_iam_roles = var.service_account_iam_roles

  # Manually enabled APIs will be removed if not added here
  services = var.services
}


