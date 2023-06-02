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

 module "mon-firestore-document-reads" {
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
    condition_threshold = {
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
    condition_threshold = {
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
    condition_threshold = {
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
  display_name = "MOBILITY|${var.env_alert}|firestore|logs_error|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "firestore_logs_error"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Firestore Instance - Logs-based metric error" = {
    condition_threshold = {
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
}

module "mon-cloudfunction-execution-count" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|cloudfunction|execution_count|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "cloudfunction_execution_count"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Cloud Function - Execution count" = {
    condition_threshold = {
      filter     = "resource.type = \"cloud_function\" AND metric.type = \"cloudfunctions.googleapis.com/function/execution_count\""
      duration   = "0s"
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

module "mon-cloudfunction-logs-error" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|cloudfunction|logs_error|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "cloudfunction_logs_error"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Cloud Function - Logs-based metric error" = {
    condition_threshold = {
      filter     = "resource.type = \"cloud_function\" AND metric.type = \"logging.googleapis.com/logs_based_metrics_error_count\""
      duration   = "0s"
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

module "mon-cloudfunction-network-egress" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|cloudfunction|network_egress|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "cloudfunction_network_egress"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "Cloud Function - Network Egress" = {
    condition_threshold = {
      filter     = "resource.type = \"cloud_function\" AND metric.type = \"cloudfunctions.googleapis.com/function/network_egress\""
      duration   = "0s"
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

module "mon-storage-request-count" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|storage|GCS|request_count|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "storage_request_count"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "GCS Bucket - API Request Count" = {
    condition_threshold = {
      filter     = "resource.type = \"gcs_bucket\" AND metric.type = \"storage.googleapis.com/api/request_count\""
      duration   = "0s"
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

module "mon-storage-object-count" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|storage|GCS|object_count|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "storage_object_count"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "GCS Bucket - Object Count" = {
    condition_threshold = {
      filter     = "resource.type = \"gcs_bucket\" AND metric.type = \"storage.googleapis.com/storage/object_count\""
      duration   = "0s"
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

module "mon-storage-total-bytes" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|storage|GCS|total_bytes|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "storage_total_bytes"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "GCS Bucket - Total bytes" = {
    condition_threshold = {
      filter     = "resource.type = \"gcs_bucket\" AND metric.type = \"storage.googleapis.com/storage/total_bytes\""
      duration   = "0s"
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

module "mon-storage-received-bytes" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|storage|GCS|received_bytes|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "storage_received_bytes"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "GCS Bucket - Received bytes" = {
    condition_threshold = {
      filter     = "resource.type = \"gcs_bucket\" AND metric.type = \"storage.googleapis.com/network/received_bytes_count\""
      duration   = "0s"
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

module "mon-storage-sent-bytes" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|storage|GCS|sent_bytes|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "storage_sent_bytes"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "GCS Bucket - Sent bytes" = {
    condition_threshold = {
      filter     = "resource.type = \"gcs_bucket\" AND metric.type = \"storage.googleapis.com/network/sent_bytes_count\""
      duration   = "0s"
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

module "mon-loadbalancer-backend-latencies" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|load_balancer|https_lb||warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "loadbalancer_backend_lantencies"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "HTTP/S Load Balancing - Backend Latencies" = {
    condition_threshold = {
      filter     = "resource.type = \"https_lb_rule\" AND metric.type = \"loadbalancing.googleapis.com/https/backend_latencies\""
      duration   = "0s"
      comparison = "COMPARISON_GT"
      threshold_value = "5"
      aggregations_enabled = "true"
      aggregations_alignment_period = "300s"
      aggregations_per_series_aligner = "ALIGN_PERCENTILE_99"
      trigger_enabled = true
      trigger_count = 1
   }
  }
 }
}

module "mon-loadbalancer-backend-request" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|load_balancer|https_lb|request_count|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "loadbalancer_request_count"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "HTTP/S Load Balancing - Request count" = {
    condition_threshold = {
      filter     = "resource.type = \"https_lb_rule\" AND metric.type = \"loadbalancing.googleapis.com/https/backend_request_count\""
      duration   = "0s"
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

module "mon-loadbalancer-backend-request" {
  source = "./modules/monitoring-alert-policy"
  display_name = "MOBILITY|${var.env_alert}|load_balancer|https_lb|request_count|warn|metric"
  project_id = var.project_id
  user_labels = {env = "${var.env}", purpose = "loadbalancer_request_count"}
  combiner = "OR"
  enabled = true
  notification_channels = [
    google_monitoring_notification_channel.email.name,
    google_monitoring_notification_channel.snow.name
  ]

  conditions = {
    "HTTP/S Load Balancing - Request count" = {
    condition_threshold = {
      filter     = "resource.type = \"https_lb_rule\" AND metric.type = \"loadbalancing.googleapis.com/https/backend_request_count\""
      duration   = "0s"
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