output "dlq_url" {
  description = "Dead Letter Queue URL"
  value       = aws_sqs_queue.dlq.url
}

output "dlq_arn" {
  description = "Dead Letter Queue ARN"
  value       = aws_sqs_queue.dlq.arn
}

output "lambda_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.bndes_lambda.arn
}

output "lambda_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.bndes_lambda.function_name
}

output "lambda_role_arn" {
  description = "Lambda IAM role ARN"
  value       = aws_iam_role.lambda_role.arn
}