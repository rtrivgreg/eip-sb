aws_region        = "us-east-1"
state_bucket_name = "rg-tf-state-dev"

default_tags = {
  Project     = "vpc-endpoints"
  Environment = "dev"
  ManagedBy   = "terraform"
  Owner       = "rg"
}