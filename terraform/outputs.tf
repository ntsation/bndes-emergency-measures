output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "ECR repository name"
  value       = module.ecr.repository_name
}

output "s3_bucket_name" {
  description = "S3 bucket name for storing BNDES data"
  value       = module.s3.bucket_name
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}

output "s3_kms_key_arn" {
  description = "KMS key ARN for S3 encryption"
  value       = module.s3.kms_key_arn
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = module.lambda.lambda_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = module.lambda.lambda_arn
}

output "dlq_url" {
  description = "Dead Letter Queue URL"
  value       = module.lambda.dlq_url
}

output "dlq_arn" {
  description = "Dead Letter Queue ARN"
  value       = module.lambda.dlq_arn
}

output "log_group_name" {
  description = "CloudWatch log group name"
  value       = module.monitoring.log_group_name
}

output "alarm_topic_arn" {
  description = "SNS topic ARN for alarms"
  value       = module.monitoring.alarm_topic_arn
}

output "dashboard_url" {
  description = "CloudWatch dashboard URL"
  value       = module.monitoring.dashboard_url
}

output "schedule_rule_name" {
  description = "CloudWatch Events schedule rule name"
  value       = module.schedule.rule_name
}