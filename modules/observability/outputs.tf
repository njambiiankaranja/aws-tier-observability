output "log_group_name" {
  value       = aws_cloudwatch_log_group.app_logs.name
  description = "The name of the CloudWatch log group for application logs."
}

output "alarm_name" {
  value       = aws_cloudwatch_metric_alarm.ecs_cpu_high.alarm_name
  description = "The name of the CloudWatch CPU utilization alarm."
}