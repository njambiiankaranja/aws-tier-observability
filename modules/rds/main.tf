# 1. DB Subnet Group (Deploys database across private subnets for Multi-AZ redundancy)
resource "aws_db_subnet_group" "main" {
  name        = "${var.environment}-db-subnet-group"
  subnet_ids  = var.private_subnet_ids
  description = "Private subnet group for RDS PostgreSQL"

  tags = {
    Name = "${var.environment}-db-subnet-group"
  }
}

# 2. Managed RDS PostgreSQL Instance (Multi-AZ & Monitored)
resource "aws_db_instance" "postgres" {
  identifier             = "${var.environment}-postgres-db"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro" # Free tier / lightweight production sizing
  allocated_storage      = 20
  max_allocated_storage  = 100
  storage_type           = "gp3"
  storage_encrypted      = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  multi_az               = true # Enables High Availability standby replica
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [var.rds_sg_id]
  publicly_accessible    = false

  backup_retention_period   = 7
  backup_window             = "03:00-04:00"
  maintenance_window        = "Mon:04:30-Mon:05:30"
  skip_final_snapshot       = true
  deletion_protection       = false

  # Observability & Monitoring hooks
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade"]

  tags = {
    Name = "${var.environment}-postgres-db"
  }
}