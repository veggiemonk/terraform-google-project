output "project_id" {
  value = "${local.project_id}"
}

output "service_account_email" {
  value = "${google_service_account.app.email}"
}
