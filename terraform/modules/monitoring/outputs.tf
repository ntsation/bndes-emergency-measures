output "log_group_name" {
  description = "CloudWatch log group name"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}

output "alarm_topic_arn" {
  description = "SNS topic ARN for alarms"
  value       = aws_sns_topic.alarm_topic.arn
}

output "dashboard_url" {
  description = "CloudWatch dashboard URL"
  value       = "https://${var.aws_region}.console.aws.amazon.com/cloudwatch/home?region=${var.aws_region}#dashboards:name=${aws_cloudwatch_dashboard.lambda_dashboard.dashboard_name}"
}