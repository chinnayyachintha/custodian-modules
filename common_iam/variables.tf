variable "CloudCustodianLambdaRole" {
  type = string
}

variable "remediation_policy_name" {
  type = string
}

variable "cloudcustodian_deployment_role_name" {
  type = string
}

variable "cloudcustodian_admin_role_arn" {
  type = string
}

variable "mailer_queue_account_id" {
  description = "Delegated account ID where the custodian mailer SQS exists"
  type        = string
}

variable "mailer_queue_name" {
  description = "Name of the custodian mailer SQS queue"
  type        = string
  default     = "custodian-mailer-standard"
}

variable "mailer_queue_region" {
  description = "Region where the custodian mailer SQS queue exists"
  type        = string
  default     = "us-east-1"
}