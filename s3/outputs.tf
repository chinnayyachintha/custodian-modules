output "cloudcustodian_pipeline_artifact_bucket" {
  value = aws_s3_bucket.pipeline_artifacts.id
}