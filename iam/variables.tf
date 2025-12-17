variable "cloudcustodian_admin_role_name" {
  description = "Cloud Custodian Admin (CodeBuild) Role Name"
  type        = string
  default     = "CloudCustodianAdminRole"
}

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

variable "cloudcustodian_pipeline_service_role_name" {
  description = "Cloud Custodian CodePipeline Service Role Name"
  type        = string
  default     = "CloudCustodianCodePipelineRole"
}

variable "bitbucket_connection_arn" {
  description = "ARN of CodeStar Connection for Bitbucket"
  type        = string
}

variable "bitbucket_repository" {
  description = "Bitbucket repository (org/repo)"
  type        = string
}

variable "bitbucket_branch_name" {
  description = "Bitbucket branch name"
  type        = string
  default     = "master"
}

variable "eventbridge_pipeline_role_name" {
  description = "Cloud Custodian EventBridge CodePipeline Service Role Name"
  type        = string
  default     = "EventBridgeCodePipelineRole"
}



