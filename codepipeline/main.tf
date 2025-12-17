resource "aws_codepipeline" "cloudcustodian_pipeline" {
  name     = var.cloudcustodian_pipeline_name
  role_arn = var.cloudcustodian_pipeline_role_arn

  artifact_store {
    location = var.cloudcustodian_pipeline_artifact_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "BitbucketSource"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      run_order        = 1
      output_artifacts = ["SourceOutput"]

      configuration = {
        ConnectionArn    = var.bitbucket_connection_arn
        FullRepositoryId = var.bitbucket_repository
        BranchName       = var.bitbucket_branch_name
      }
    }
  }

  stage {
    name = var.stage_name #"DeployCloudCustodianPolicies"

    action {
      name            = "Deploy-Policies"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      version         = "1"
      run_order       = 1
      input_artifacts = ["SourceOutput"]

      configuration = {
        ProjectName = var.cloudcustodian_codebuild_project_name
      }
    }
  }
}
