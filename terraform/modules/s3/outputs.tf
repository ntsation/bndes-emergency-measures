output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.bndes_data_bucket.id
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.bndes_data_bucket.arn
}

output "kms_key_arn" {
  description = "KMS key ARN for encryption"
  value       = aws_kms_key.s3_encryption_key.arn
}

output "kms_key_id" {
  description = "KMS key ID"
  value       = aws_kms_key.s3_encryption_key.key_id
}