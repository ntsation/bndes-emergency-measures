output "rule_name" {
  description = "CloudWatch Event rule name"
  value       = aws_cloudwatch_event_rule.daily_trigger.name
}

output "rule_arn" {
  description = "CloudWatch Event rule ARN"
  value       = aws_cloudwatch_event_rule.daily_trigger.arn
}