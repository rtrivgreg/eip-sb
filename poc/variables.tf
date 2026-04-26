variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_profile" {
  description = "Curated VPC profile to deploy"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["minimal", "development", "production"], var.vpc_profile)
    error_message = "vpc_profile must be one of: minimal, development, production."
  }
}
