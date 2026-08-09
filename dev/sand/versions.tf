terraform {
  required_version = "= 1.14.8"
  # Change
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }