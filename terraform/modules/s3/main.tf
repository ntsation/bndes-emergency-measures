resource "aws_kms_key" "s3_encryption_key" {
  description             = "${var.project_name} S3 bucket encryption key"
  deletion_window_in_days = 30
  enable_key_rotation     = true

  tags = {
    Name        = "${var.project_name}-s3-key"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_kms_alias" "s3_key_alias" {
  name          = "alias/${var.project_name}-s3-key"
  target_key_id = aws_kms_key.s3_encryption_key.key_id
}

resource "aws_s3_bucket" "bndes_data_bucket" {
  bucket = "${var.project_name}-bndes-data"

  tags = {
    Name        = "${var.project_name}-bndes-data"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bndes_data_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.s3_encryption_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bndes_data_bucket.id
  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.bndes_data_bucket.id

  rule {
    id     = "cleanup-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = var.lifecycle_days
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.bndes_data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "log_bucket" {
  bucket_prefix = "${var.project_name}-bndes-data-logs-"

  tags = {
    Name        = "${var.project_name}-bndes-data-logs"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_logging" "logging" {
  bucket = aws_s3_bucket.bndes_data_bucket.id

  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
}