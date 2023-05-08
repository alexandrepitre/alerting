module "monitoring" {
  source = "./modules/monitoring-alert-policy"
  display_name = "Firestore Instance - Document Writes"
  project  = var.project_id
  combiner = "OR"
  enabled = true
  notification_channels = [ ]
  user_labels = "alex label"
  conditions = {
    "Firestore Instance - Document Writes" = {
    condition_threshold = {
      filter     = "resource.type = \"firestore_instance\" AND metric.type = \"firestore.googleapis.com/document/write_count\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      aggregations_enabled = "true"
      aggreations_alignment_period   = "300s"
      aggreations_per_series_aligner = "ALIGN_MEAN"
      trigger_enabled = true
      trigger_count = 1
    }
  }
}