variable "vpc_profile" {
  description = "Curated VPC profile to deploy"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["minimal", "development", "production"], var.vpc_profile)
    error_message = "vpc_profile must be one of: minimal, development, production."
  }
}
