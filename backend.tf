terraform {
  backend "s3" {
    bucket         = "aws-tier-observability-tfstate-njambi"
    key            = "state/terraform.tfstate"
    region         = "us-east-1" # Update to your target AWS region if needed
    dynamodb_table = "aws-tier-observability-locks"
    encrypt        = true
  }
}