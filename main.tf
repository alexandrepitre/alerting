resource "google_monitoring_notification_channel" "email" {
  display_name = "Email Channel"
  type         = "email"
  labels = {
    email_address = "alexandre.pitre22l@gmail.com"
  }
}

resource "google_monitoring_notification_channel" "snow" {
  display_name = "Webhook Channel"
  type         = "webhook_basicauth"
  labels = {
    url = "http://snow"
    username = "user"
    password = "passsword"
  }
}

module "mon-firestore-document-deletes" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|firestore|document_deletes|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "firestore_document_delete"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Firestore Instance - Document Deletes" = {
    condition_threshold = {
      filter     = "metric.type=\"firestore.googleapis.com/document/delete_count\" AND resource.type=\"firestore_instance\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "10"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
}

/* module "mon-firestore-document-reads" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|firestore|document_reads|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "firestore_document_reads"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Firestore Instance - Document Reads" = {
    condition_treshold = {
      filter     = "resource.type = \"firestore_instance\" AND metric.type = \"firestore.googleapis.com/document/read_count\""
      duration   = "3600s"
      comparison = "COMPARISON_GT"
      threshold_value = "25"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
}

module "mon-firestore-document-writes" {
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
    condition_treshold = {
      filter     = "resource.type = \"firestore_instance\" AND metric.type = \"firestore.googleapis.com/document/write_count\""
      duration   = "3600s"
      comparison = "COMPARISON_GT"
      threshold_value = "25"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
}

module "mon-firestore-connected-clients" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|firestore|connected_clients|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "firestore_connected_clients"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Firestore Instance - Connected Clients" = {
    condition_treshold = {
      filter     = "resource.type = \"firestore_instance\" AND metric.type = \"firestore.googleapis.com/network/active_connections\""
      duration   = "3600s"
      comparison = "COMPARISON_GT"
      threshold_value = "5"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
}

module "mon-firestore-logs-error" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|firestore|logs_errors|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "firestore_logs_errors"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Firestore Instance - Logs-based metric errors" = {
    condition_treshold = {
      filter     = "resource.type = \"firestore_instance\" AND metric.type = \"logging.googleapis.com/logs_based_metrics_error_count\""
      duration   = "3600s"
      comparison = "COMPARISON_GT"
      threshold_value = "5"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
} */