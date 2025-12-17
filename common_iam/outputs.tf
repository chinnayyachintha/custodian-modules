output "cloudcustodian_deployment_role_arn" {
  description = "ARN of the Cloud Custodian deployment role"
  value       = aws_iam_role.cloudcustodian_deployment_role.arn
}

output "cloudcustodian_lambda_role_arn" {
  description = "ARN of the Cloud Custodian Lambda execution role"
  value       = aws_iam_role.cloudcustodian_lambda_role.arn
}
