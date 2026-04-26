locals {
  common_tags = {
    Project     = "vpce-poc"
    Environment = "poc"
    ManagedBy   = "terraform"
    VpcProfile  = var.vpc_profile
  }

  available_azs = ["us-east-1a", "us-east-1b", "us-east-1c"]

  vpc_profiles = {
    minimal = {
      name                         = "rg-poc-vpc-minimal"
      cidr                         = "10.10.0.0/16"
      az_count                     = 1
      enable_public_subnets        = true
      enable_private_subnets       = false
      enable_database_subnets      = false
      enable_nat_gateway           = false
      single_nat_gateway           = false
      enable_dns_support           = true
      enable_dns_hostnames         = true
      map_public_ip_on_launch      = true
      create_database_subnet_group = false
      enable_s3_endpoint           = false
      enable_dynamodb_endpoint     = false
    }

    development = {
      name                         = "rg-poc-vpc-development"
      cidr                         = "10.20.0.0/16"
      az_count                     = 2
      enable_public_subnets        = true
      enable_private_subnets       = true
      enable_database_subnets      = false
      enable_nat_gateway           = true
      single_nat_gateway           = true
      enable_dns_support           = true
      enable_dns_hostnames         = true
      map_public_ip_on_launch      = true
      create_database_subnet_group = false
      enable_s3_endpoint           = true
      enable_dynamodb_endpoint     = false
    }

    production = {
      name                         = "rg-poc-vpc-production"
      cidr                         = "10.30.0.0/16"
      az_count                     = 3
      enable_public_subnets        = true
      enable_private_subnets       = true
      enable_database_subnets      = true
      enable_nat_gateway           = true
      single_nat_gateway           = false
      enable_dns_support           = true
      enable_dns_hostnames         = true
      map_public_ip_on_launch      = false
      create_database_subnet_group = false
      enable_s3_endpoint           = true
      enable_dynamodb_endpoint     = true
    }
  }

  profile = local.vpc_profiles[var.vpc_profile]

  azs = slice(local.available_azs, 0, local.profile.az_count)

  public_subnets = local.profile.enable_public_subnets ? [
    for i, az in local.azs : cidrsubnet(local.profile.cidr, 8, i)
  ] : []

  private_subnets = local.profile.enable_private_subnets ? [
    for i, az in local.azs : cidrsubnet(local.profile.cidr, 8, i + 10)
  ] : []

  database_subnets = local.profile.enable_database_subnets ? [
    for i, az in local.azs : cidrsubnet(local.profile.cidr, 8, i + 20)
  ] : []
}
