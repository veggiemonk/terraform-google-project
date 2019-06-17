output "project_id" {
  value = "${local.project_id}"
}

output "owners" {
  value = "${google_project_iam_policy.owners.*.etag}"
}

output "editors" {
  value = "${google_project_iam_policy.editors.*.etag}"
}
