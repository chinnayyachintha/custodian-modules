output "cloudcustodian_admin_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "cloudcustodian_pipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}