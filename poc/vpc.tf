module "poc_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.profile.name
  cidr = local.profile.cidr

  azs = local.azs

  public_subnets   = local.public_subnets
  private_subnets  = local.private_subnets
  database_subnets = local.database_subnets

  enable_nat_gateway = local.profile.enable_nat_gateway
  single_nat_gateway = local.profile.single_nat_gateway

  enable_dns_support   = local.profile.enable_dns_support
  enable_dns_hostnames = local.profile.enable_dns_hostnames

  map_public_ip_on_launch = local.profile.map_public_ip_on_launch

  create_database_subnet_group = local.profile.create_database_subnet_group

  manage_default_network_acl    = false
  manage_default_security_group = false

  tags = local.common_tags
}
