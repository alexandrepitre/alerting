variable "display_name" {
  type        = string
  description = "(Required) A short name or phrase used to identify the policy in dashboards, notifications, and incidents. To avoid confusion, don't use the same display name for multiple policies in the same project. The name is limited to 512 Unicode characters."
}

variable "project_id" {
  type        = string
  description = "(Required) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "combiner" {
  type        = string
  description = "(Required) How to combine the results of multiple conditions to determine if an incident should be opened. Possible values are AND, OR, and AND_WITH_MATCHING_RESOURCE."
}

variable "user_labels" {
  type        = map(string)
  default     = null
  description = "(Optional) This field is intended to be used for organizing and identifying the AlertPolicy objects.The field can contain up to 64 entries. Each key and value is limited to 63 Unicode characters or 128 bytes, whichever is smaller. Labels and values can contain only lowercase letters, numerals, underscores, and dashes. Keys must begin with a letter."
}

variable "documentation" {
  type = any
  default     = {}
  description = "(Optional) Documentation that is included with notifications and incidents related to this policy. Best practice is for the documentation to include information to help responders understand, mitigate, escalate, and correct the underlying problems detected by the alerting policy. Notification channels that have limited capacity might not show this documentation."
}

variable "notification_channels" {
  type        = list(string)
  description = "(Optional) Identifies the notification channels to which notifications should be sent when incidents are opened or closed or when new violations occur on an already opened incident. Each element of this array corresponds to the name field in each of the NotificationChannel objects that are returned from the notificationChannels.list method. The syntax of the entries in this field is projects/[PROJECT_ID]/notificationChannels/[CHANNEL_ID]"
}

variable "conditions" {
  type = map(map(any))
  description = "(Required) A list of conditions for the policy. The conditions are combined by AND or OR according to the combiner field. If the combined conditions evaluate to true, then an incident is created. A policy can have from one to six conditions. https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/monitoring_alert_policy"
}

variable "enabled" {
  type = bool
  description = "(Optional) Whether or not the policy is enabled. The default is true."
  default = true
}
