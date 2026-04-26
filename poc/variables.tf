variable "aws_region" {
  type        = string
  description = "AWS region for this environment."
  default     = "us-east-1"
}

variable "enabled" {
  type        = bool
  description = "Enable or disable resource creation."
  default     = true
}

variable "vpc_id" {
  type        = string
  description = "Target VPC ID."
}

variable "service_name" {
  type        = string
  description = "Endpoint service name, e.g. com.amazonaws.us-east-1.ec2messages."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the interface endpoint."
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs attached to the interface endpoint ENIs."
}

variable "private_dns_enabled" {
  type        = bool
  description = "Whether private DNS is enabled for the endpoint."
  default     = true
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
