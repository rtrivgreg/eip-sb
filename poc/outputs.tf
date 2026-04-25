output "poc_vpc_id" {
  value = module.poc_vpc.vpc_id
}

output "poc_public_subnets" {
  value = module.poc_vpc.public_subnets
}

output "poc_private_subnets" {
  value = module.poc_vpc.private_subnets
}