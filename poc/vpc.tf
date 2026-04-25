module "poc_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"  # pin a major version[web:199][web:387]

  name = "rg-poc-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["us-east-1a"]
  public_subnets  = ["10.10.1.0/24"]
  #private_subnets = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false

  tags = {
    Project     = "vpce-poc"
    Environment = "poc"
    ManagedBy   = "terraform"
  }
}