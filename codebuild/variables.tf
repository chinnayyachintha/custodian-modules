variable "cloudcustodian_deployment_role_name" {
  description = "Cloud Custodian Deployment Role Name"
  type        = string
  default     = "CloudCustodianDeploymentRole"
}

variable "management_account_id" {
  description = "AWS Organizations Management Account ID"
  type        = string
}

variable "org_read_role_name" {
  description = "Role in Management Account used to list organization accounts"
  type        = string
  default     = "C7NOrgReadRole"
}