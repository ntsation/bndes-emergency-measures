variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
  default     = "bndes-emergency-measures"
}

variable "lambda_timeout" {
  type        = number
  description = "Lambda timeout in seconds"
  default     = 900
}

variable "lambda_memory_size" {
  type        = number
  description = "Lambda memory size in MB"
  default     = 1024
}

variable "alarm_email" {
  type        = string
  description = "Email address for CloudWatch alarm notifications"
  default     = ""
}

variable "log_retention_days" {
  type        = number
  description = "CloudWatch logs retention period in days"
  default     = 30
}