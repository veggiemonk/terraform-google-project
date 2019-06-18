output "project_id" {
  value = local.project_id
}

output "service_account_email" {
  value = google_service_account.app.email
}

output "service_account_private_key" {
  sensitive = true
  value     = google_service_account_key.app.private_key
}
