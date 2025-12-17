#-------------------------------------------------
# S3 Bucket for Cloud Custodian Pipeline Artifacts
#-------------------------------------------------

module "s3_pipeline_artifacts" {
  source = "../s3"

  s3_pipeline_artifact_bucket_name = var.s3_pipeline_artifact_bucket_name

}

#-----------------------------------------------
# IAM Role
#-----------------------------------------------
module "iam" {
  source = "../iam"

  cloudcustodian_admin_role_name            = var.cloudcustodian_admin_role_name
  cloudcustodian_deployment_role_name       = var.cloudcustodian_deployment_role_name
  management_account_id                     = var.management_account_id
  org_read_role_name                        = var.org_read_role_name
  cloudcustodian_pipeline_service_role_name = var.cloudcustodian_pipeline_service_role_name
  bitbucket_connection_arn                  = var.bitbucket_connection_arn
  bitbucket_repository                      = var.bitbucket_repository
  bitbucket_branch_name                     = var.bitbucket_branch_name

}

#-----------------------------------------------
# CodeBuild Project
#-----------------------------------------------
module "codebuild" {
  source = "../codebuild"

  depends_on = [module.iam]

  cloudcustodian_deployment_role_name = var.cloudcustodian_deployment_role_name
  management_account_id               = var.management_account_id
  org_read_role_name                  = var.org_read_role_name

}
