resource "aws_codebuild_project" "cloudcustodian" {
  name         = "CloudCustodianCodeBuild"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:4.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "CLOUD_CUSTODIAN_DEPLOY_ROLE"
      value = var.cloudcustodian_deployment_role_name
    }

    environment_variable {
      name  = "MANAGEMENT_ACCOUNT_ID"
      value = var.management_account_id
    }

    environment_variable {
      name  = "ORG_LIST_ROLE_NAME"
      value = var.org_read_role_name
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yaml"
  }

}
