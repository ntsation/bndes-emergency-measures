resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.lambda_name}"
  retention_in_days = var.retention_days

  tags = {
    Name        = "${var.project_name}-lambda-logs"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "${var.project_name}-lambda-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors Lambda function errors"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = var.lambda_name
  }

  tags = {
    Name        = "${var.project_name}-lambda-errors-alarm"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_duration" {
  alarm_name          = "${var.project_name}-lambda-duration"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Duration"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Average"
  threshold           = "300000"
  alarm_description   = "This metric monitors Lambda function duration"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = var.lambda_name
  }

  tags = {
    Name        = "${var.project_name}-lambda-duration-alarm"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda_throttles" {
  alarm_name          = "${var.project_name}-lambda-throttles"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors Lambda function throttles"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = var.lambda_name
  }

  tags = {
    Name        = "${var.project_name}-lambda-throttles-alarm"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

# SNS Topic for alarm notifications
resource "aws_sns_topic" "alarm_topic" {
  name = "${var.project_name}-alarms"

  tags = {
    Name        = "${var.project_name}-alarms"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_sns_topic_subscription" "email_subscription" {
  count     = var.alarm_email != "" ? 1 : 0
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alarm_email
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors_sns" {
  alarm_name          = "${var.project_name}-lambda-errors-sns"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "This metric monitors Lambda function errors and sends SNS notifications"
  treat_missing_data  = "notBreaching"

  dimensions = {
    FunctionName = var.lambda_name
  }

  alarm_actions = [aws_sns_topic.alarm_topic.arn]

  tags = {
    Name        = "${var.project_name}-lambda-errors-sns-alarm"
    Project     = var.project_name
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

resource "aws_cloudwatch_dashboard" "lambda_dashboard" {
  dashboard_name = "${var.project_name}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Lambda", "Invocations", [{ "name" = "FunctionName", "value" = var.lambda_name }]],
            [".", "Errors", "."],
            [".", "Duration", "."],
            [".", "Throttles", "."]
          ]
          period = 300
          stat   = "Sum"
          region = var.aws_region
          title  = "Lambda Metrics"
        }
      }
    ]
  })
}