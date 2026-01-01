variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "lambda_timeout" {
  type        = number
  description = "Lambda timeout in seconds"
}

variable "lambda_memory_size" {
  type        = number
  description = "Lambda memory size in MB"
}

variable "ecr_repository_url" {
  type        = string
  description = "ECR repository URL"
}

variable "ecr_repository_name" {
  type        = string
  description = "ECR repository name"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name for storing processed data"
}

variable "s3_bucket_arn" {
  type        = string
  description = "S3 bucket ARN"
}

variable "s3_kms_key_arn" {
  type        = string
  description = "KMS key ARN for S3 encryption"
  default     = ""
}