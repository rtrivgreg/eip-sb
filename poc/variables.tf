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