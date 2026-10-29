variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for the ALB"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for ECS Fargate tasks"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for the ALB"
}

variable "ecs_tasks_sg_id" {
  type        = string
  description = "Security group ID for ECS tasks"
}