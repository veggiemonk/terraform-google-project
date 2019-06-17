output "projects" {
  value = google_project.trainee.*.number
}

