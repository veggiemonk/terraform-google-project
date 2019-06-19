output "project" {
  value = module.project.project_id
}

output "sa" {
  value = module.project.service_account_email
}

output "key" {
  sensitive = true
  value     = module.project.service_account_private_key
}