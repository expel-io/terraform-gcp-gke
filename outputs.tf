# Pubsub Subscription output
output "pubsub_subscription_name" {
  description = "Name of the pub/sub subscription Expel will consume from"
  value       = "projects/${var.project_id}/subscriptions/${google_pubsub_subscription.expel_pubsub_subscription.name}"
}

# Service account key output
output "service_account_key" {
  description = "The service account credentials required by Expel for onboarding"
  value       = google_service_account_key.expel_svc_acct_key.private_key
  sensitive   = true
}
