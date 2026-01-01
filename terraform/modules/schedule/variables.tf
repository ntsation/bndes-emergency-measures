variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}

variable "lambda_arn" {
  type        = string
  description = "Lambda function ARN"
}

variable "lambda_name" {
  type        = string
  description = "Lambda function name"
}

variable "schedule_expression" {
  type        = string
  description = "CloudWatch Events schedule expression"
  default     = "cron(0 3 * * ? *)"
}