# ---------------------------------------------------------------------------------------------------------------------
# PREPARE PROVIDERS
# ---------------------------------------------------------------------------------------------------------------------

provider "google" {
  region = var.region
}

provider "google-beta" {
  region = var.region
}

module "project" {
  source = "../../modules/gcp-projects-workshop"
  //  source = "github.com/veggiemonk/terraform-google-project//modules/gcp-projects-workshop"

  #
  # these variables should use env vars
  #
  # export TF_VAR_billing_account=
  # export TF_VAR_org=
  # export TF_VAR_email_owner=
  # export TF_VAR_trainee1=
  # export TF_VAR_trainee2=

  billing_account = var.billing_account
  org_id          = var.org_id
  email_owner     = var.email_owner
  emails_editor   = [var.trainee1, var.trainee2]

  project_prefix = "trainee"

  # Will be replaced at every apply!
  services = var.services
}


