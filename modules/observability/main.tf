resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/aws/ecs/aws-tier-observability-app"
  retention_in_days = 30

  tags = {
    Environment = "production"
    Project     = "aws-tier-observability"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "aws-tier-observability-ecs-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when ECS service CPU utilization exceeds 80% for 10 minutes."

  dimensions = {
    ClusterName = "production-ecs-cluster"
    ServiceName = "production-app-service"
  }
}