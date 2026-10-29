output "db_endpoint" {
  value       = aws_db_instance.postgres.endpoint
  description = "The connection endpoint for the database"
}

output "db_address" {
  value       = aws_db_instance.postgres.address
  description = "The hostname of the RDS instance"
}