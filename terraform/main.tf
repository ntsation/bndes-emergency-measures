module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  aws_region   = var.aws_region
}

module "lambda" {
  source               = "./modules/lambda"
  project_name         = var.project_name
  aws_region           = var.aws_region
  lambda_timeout       = var.lambda_timeout
  lambda_memory_size   = var.lambda_memory_size
  ecr_repository_url    = module.ecr.repository_url
  ecr_repository_name  = module.ecr.repository_name
  s3_bucket_name       = module.s3.bucket_name
  s3_bucket_arn        = module.s3.bucket_arn
  s3_kms_key_arn       = module.s3.kms_key_arn
}

module "monitoring" {
  source             = "./modules/monitoring"
  project_name       = var.project_name
  aws_region         = var.aws_region
  lambda_name        = module.lambda.lambda_name
  alarm_email        = var.alarm_email
  retention_days     = var.log_retention_days
}

module "schedule" {
  source         = "./modules/schedule"
  project_name   = var.project_name
  lambda_arn     = module.lambda.lambda_arn
  lambda_name    = module.lambda.lambda_name
}