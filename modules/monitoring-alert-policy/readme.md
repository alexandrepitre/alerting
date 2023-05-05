 ## **Monitoring-Alert-Module**

 Monitoring-Alert Module helps to an alerting policy describes the circumstances
 under which you want to be alerted and how you want to be notified. Alerting policies 
 that are used to track metric data collected by Cloud Monitoringare called metric-based alerting policies.


## **Usage**

```hcl

module "mon-storage-alert-policy" {
  source = "source_url"

  display_name          = "display_name"
  combiner              = "OR"
  project_id            = "project_id"
  notification_channels = []
  conditions = {
    "GCS Bucket - Sent bytes" = {
      condition_threshold = {
        filter                          = "metric.type"
        duration                        = "60s"
        comparison                      = "COMPARISON_GT"
        threshold_value                 = "46000"
        aggregations_enabled            = "true"
        aggregations_alignment_period   = "300s"
        aggregations_per_series_aligner = "ALIGN_MEAN"

        trigger_enabled = "true"
        trigger_count   = "1"
      }
    }
  }
  user_labels  = var.labels     
}

```

## Inputs

| **Name** | **Description** | **Type** | **Default** | **Required** |
|------|-------------|------|---------|:--------:|
|display_name |	A Unique name for alert display name | string |	-	| yes |
|project_id |	Project ID where alert policy will be created. |string | "" |no |
|combiner | how to combine the results of multiple conditions to determine  | string | " " | yes |
|condition | resource metric condition  | string |  "" | yes |
|filter |  fileter | where the metric type defined | string | ""  |yes | 
|duration | The amount of time that a time series must fail to report new data to be considered failing|   string |  "" |yes |
|threshold |A threshold is a performance value you can set for a metric | string | " " | yes |
|aggregation | The approach to be used to align individual time series | srting | " " | no |


## Outputs

| **Name** | **Description** |
|------|-------------|
| alert | The created alert policy |
| name | alert name. |
| id | alert id. |
