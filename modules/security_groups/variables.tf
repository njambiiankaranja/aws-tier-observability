variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where security groups will be created"
}

variable "environment" {
  type        = string
  description = "Environment name"
}