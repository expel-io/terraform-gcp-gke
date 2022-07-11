output "pubsub_subscription_name" {
  description = "Name of the Kinesis data stream Expel will consume from"
  value       = google_pubsub_topic.expel_pubsub_topic.name
}

output "service_account_key" {
  description = "The service account credentials required by Expel for onboarding"
  value       = google_service_account_key.expel_svc_acct_key.private_key
  sensitive   = true
}