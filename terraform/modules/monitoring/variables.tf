variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}

variable "lambda_name" {
  type        = string
  description = "Lambda function name"
}

variable "alarm_email" {
  type        = string
  description = "Email address for CloudWatch alarm notifications"
  default     = ""
}

variable "retention_days" {
  type        = number
  description = "CloudWatch logs retention period in days"
  default     = 30
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}