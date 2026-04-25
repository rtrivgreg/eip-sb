module "poc_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"  # keep it explicit, 5.x is stable and widely used[web:382][web:400]

  name = "rg-poc-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnets = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # Important: let AWS keep the default NACL & default SG as-is for this POC
  manage_default_network_acl   = false  # disables aws_default_network_acl.this inside the module[web:413][web:415]
  manage_default_security_group = false # optional, avoids recreating default SG if you don't care to manage it[web:417][web:415]

  tags = {
    Project     = "vpce-poc"
    Environment = "poc"
    ManagedBy   = "terraform"
  }
}
