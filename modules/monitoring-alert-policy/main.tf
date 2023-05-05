resource "google_monitoring_alert_policy" "alert_policy" {
  display_name          = var.display_name
  project               = var.project_id
  combiner              = var.combiner
  notification_channels = var.notification_channels
  user_labels           = var.user_labels
  enabled               = var.enabled
  dynamic "documentation" {
    
   for_each = length(keys(var.documentation)) == 0 ? [] : [var.documentation]

    content {
      content = lookup(var.documentation, "content", "")
      mime_type       = lookup(var.documentation, "mime_type", "")
    }
  }

  dynamic "conditions" {
    for_each = { for key, value in var.conditions :
      key => value
    }

    content {
      display_name = conditions.key

      dynamic "condition_threshold" {
        for_each = lookup(conditions.value, "condition_threshold", null) == null ? [] : [tolist([conditions.value.condition_threshold])]

        content {
          threshold_value    = lookup(conditions.value.condition_threshold, "threshold_value", null) == null ? null : lookup(conditions.value.condition_threshold, "threshold_value")
          denominator_filter = lookup(conditions.value.condition_threshold, "denominator_filter", null) == null ? null : lookup(conditions.value.condition_threshold, "denominator_filter")
          filter             = lookup(conditions.value.condition_threshold, "filter", null) == null ? null : lookup(conditions.value.condition_threshold, "filter")
          duration           = lookup(conditions.value.condition_threshold, "duration", null) == null ? null : lookup(conditions.value.condition_threshold, "duration")
          comparison         = lookup(conditions.value.condition_threshold, "comparison", null) == null ? null : lookup(conditions.value.condition_threshold, "comparison")

          dynamic "aggregations" {
            for_each = lookup(conditions.value.condition_threshold, "aggregations_enabled", "false") == "false" ? [] : [tolist([conditions.value.condition_threshold])]

            content {
              alignment_period     = lookup(conditions.value.condition_threshold, "aggregations_alignment_period", null) == null ? null : lookup(conditions.value.condition_threshold, "aggregations_alignment_period")
              per_series_aligner   = lookup(conditions.value.condition_threshold, "aggregations_per_series_aligner", null) == null ? null : lookup(conditions.value.condition_threshold, "aggregations_per_series_aligner")
              group_by_fields      = lookup(conditions.value.condition_threshold, "aggregations_group_by_fields", null) == null ? null : lookup(conditions.value.condition_threshold, "aggregations_group_by_fields")
              cross_series_reducer = lookup(conditions.value.condition_threshold, "aggregations_cross_series_reducer", null) == null ? null : lookup(conditions.value.condition_threshold, "aggregations_cross_series_reducer")
            }
          }

          dynamic "denominator_aggregations" {
            for_each = lookup(conditions.value.condition_threshold, "denominator_aggregations_enabled", "false") == "false" ? [] : [tolist([conditions.value.condition_threshold])]

            content {
              alignment_period     = lookup(conditions.value.condition_threshold, "denominator_aggregations_alignment_period", null) == null ? null : lookup(conditions.value.condition_threshold, "denominator_aggregations_alignment_period")
              per_series_aligner   = lookup(conditions.value.condition_threshold, "denominator_aggregations_per_series_aligner", null) == null ? null : lookup(conditions.value.condition_threshold, "denominator_aggregations_per_series_aligner")
              group_by_fields      = lookup(conditions.value.condition_threshold, "denominator_aggregations_group_by_fields", null) == null ? null : lookup(conditions.value.condition_threshold, "denominator_aggregations_group_by_fields")
              cross_series_reducer = lookup(conditions.value.condition_threshold, "denominator_aggregations_cross_series_reducer", null) == null ? null : lookup(conditions.value.condition_threshold, "denominator_aggregations_cross_series_reducer")
            }
          }

          dynamic "trigger" {
            for_each = lookup(conditions.value.condition_threshold, "trigger_enabled", "false") == "false" ? [] : [tolist([conditions.value.condition_threshold])]

            content {
              percent = lookup(conditions.value.condition_threshold, "trigger_percent", null) == null ? null : lookup(conditions.value.condition_threshold, "trigger_percent")
              count   = lookup(conditions.value.condition_threshold, "trigger_count", null) == null ? null : lookup(conditions.value.condition_threshold, "trigger_count")
            }
          }


        }
      }

      dynamic "condition_monitoring_query_language" {
        for_each = lookup(conditions.value, "condition_monitoring_query_language", null) == null ? [] : [tolist([conditions.value.condition_monitoring_query_language])]

        content {
          query    = lookup(conditions.value.condition_monitoring_query_language, "query", null) == null ? null : lookup(conditions.value.condition_monitoring_query_language, "query")
          duration = lookup(conditions.value.condition_monitoring_query_language, "duration", null) == null ? null : lookup(conditions.value.condition_monitoring_query_language, "duration")

          dynamic "trigger" {
            for_each = lookup(conditions.value.condition_monitoring_query_language, "trigger_enabled", "false") == null ? [] : [tolist([conditions.value.condition_monitoring_query_language])]

            content {
              percent = lookup(conditions.value.condition_monitoring_query_language, "trigger_percent", null) == null ? null : lookup(conditions.value.condition_monitoring_query_language, "trigger_percent")
              count   = lookup(conditions.value.condition_monitoring_query_language, "trigger_count", null) == null ? null : lookup(conditions.value.condition_monitoring_query_language, "trigger_count")
            }
          }
        }
      }

      dynamic "condition_absent" {
        for_each = lookup(conditions.value, "condition_absent", null) == null ? [] : [tolist([conditions.value.condition_absent])]

        content {
          filter   = lookup(conditions.value.condition_absent, "filter", null) == null ? null : lookup(conditions.value.condition_absent, "filter")
          duration = lookup(conditions.value.condition_absent, "duration", null) == null ? null : lookup(conditions.value.condition_absent, "duration")

          dynamic "aggregations" {
            for_each = lookup(conditions.value.condition_absent, "aggregations_enabled", "false") == "false" ? [] : [tolist([conditions.value.condition_absent])]

            content {
              alignment_period     = lookup(conditions.value.condition_absent, "aggregations_alignment_period", null) == null ? null : lookup(conditions.value.condition_absent, "aggregations_alignment_period")
              per_series_aligner   = lookup(conditions.value.condition_absent, "aggregations_per_series_aligner", null) == null ? null : lookup(conditions.value.condition_absent, "aggregations_per_series_aligner")
              group_by_fields      = lookup(conditions.value.condition_absent, "aggregations_group_by_fields", null) == null ? null : lookup(conditions.value.condition_absent, "aggregations_group_by_fields")
              cross_series_reducer = lookup(conditions.value.condition_absent, "aggregations_cross_series_reducer", null) == null ? null : lookup(conditions.value.condition_absent, "aggregations_cross_series_reducer")
            }
          }

          dynamic "trigger" {
            for_each = lookup(conditions.value.condition_absent, "trigger_enabled", "false") == "false" ? [] : [tolist([conditions.value.condition_absent])]

            content {
              percent = lookup(conditions.value.condition_absent, "trigger_percent", null) == null ? null : lookup(conditions.value.condition_absent, "trigger_percent")
              count   = lookup(conditions.value.condition_absent, "trigger_count", null) == null ? null : lookup(conditions.value.condition_absent, "trigger_count")
            }
          }


        }
      }

    }

  }
}
