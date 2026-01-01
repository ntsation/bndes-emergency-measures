variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "enable_versioning" {
  type        = bool
  description = "Enable S3 versioning"
  default     = true
}

variable "lifecycle_days" {
  type        = number
  description = "Number of days to keep old versions"
  default     = 90
}