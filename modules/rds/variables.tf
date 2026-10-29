variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the database subnet group"
}

variable "rds_sg_id" {
  type        = string
  description = "Security group ID for the RDS instance"
}

variable "db_name" {
  type        = string
  description = "Name of the initial database to create"
  default     = "appdb"
}

variable "db_username" {
  type        = string
  description = "Master username for the database"
  default     = "dbadmin"
}

variable "db_password" {
  type        = string
  description = "Master password for the database"
  sensitive   = true
}