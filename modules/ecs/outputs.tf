output "alb_dns_name" {
  value       = aws_lb.main.dns_name
  description = "Public URL to access your deployed application"
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}