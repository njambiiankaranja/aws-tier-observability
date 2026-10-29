output "alb_dns_name" {
  value       = module.ecs.alb_dns_name
  description = "The public URL to access your multi-tier application"
}

output "db_endpoint" {
  value       = module.rds.db_endpoint
  description = "The connection endpoint for the PostgreSQL database"
  sensitive   = true
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the custom VPC"
}