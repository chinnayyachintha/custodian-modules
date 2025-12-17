variable "cloudcustodian_pipeline_name" {
  description = "Name of the Cloud Custodian CodePipeline"
  type        = string
  default     = "CloudCustodianPipeline"
}

variable "cloudcustodian_pipeline_role_arn" {
  description = "ARN of the CodePipeline Service Role"
  type        = string
}

variable "cloudcustodian_pipeline_artifact_bucket" {
  description = "S3 Bucket for CodePipeline Artifacts"
  type        = string
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

variable "stage_name" {
  description = "Name of the deployment stage in CodePipeline"
  type        = string
  default     = "DeployCloudCustodianPolicies"
}

variable "cloudcustodian_codebuild_project_name" {
  description = "Name of the CodeBuild project for deploying Cloud Custodian policies"
  type        = string
}