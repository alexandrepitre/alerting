resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Channel"
  type         = "email"
  labels = {
    email_address = "alexandre.pitre22l@gmail.com"
  }
}

resource "google_monitoring_notification_channel" "snow" {
  display_name = "Webhook Channel"
  type         = "webhook"
  labels = {
    url = "http://snow"
    username = "user"
    password = "passsword"
  }
}

module "monitoring" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|firestore|document_writes|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "firestore_document_writes"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Firestore Instance - Document Writes" = {
    condition_absent = {
      filter     = "resource.type = \"firestore_instance\" AND metric.type = \"firestore.googleapis.com/document/write_count\""
      duration   = "3600s"
      comparison = "COMPARISON_GT"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
}