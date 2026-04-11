variable "aws_region" {
  type        = string
  description = "AWS region for the Terraform state bucket."
  default     = "us-east-1"
}

variable "state_bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name for Terraform state."
  default     = "rg-tf-state-dev"
}

variable "default_tags" {
  type = map(string)
  default = {
    Project     = "vpc-endpoints"
    Environment = "dev"
    ManagedBy   = "terraform"
    Owner       = "rg"
  }
}