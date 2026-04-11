aws_region          = "us-east-1"
enabled             = false
vpc_id              = "vpc-0c4f804e905f41635"
service_name        = "com.amazonaws.us-east-1.ec2messages"
subnet_ids          = ["subnet-0e2edd5fa0e3907f0"]
security_group_ids  = ["sg-02c3be99d2bc862ca"]
private_dns_enabled = true

default_tags = {
  Project     = "vpc-endpoints"
  Environment = "dev"
  ManagedBy   = "terraform"
  Owner       = "rg"
}