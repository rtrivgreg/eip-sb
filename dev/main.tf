module "ec2messages_endpoint" {
  source = "../modules/interface_endpoint"
  
  #for instance type toggle begin
  #instance_id         = var.instance_id
  instance_type       = var.instance_type
  #for instance type toggle end

  enabled             = var.enabled
  name                = "ec2messages-interface-endpoint"
  vpc_id              = var.vpc_id
  service_name        = var.service_name
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = var.private_dns_enabled
  tags                = var.default_tags
}

output "debug_root_enabled" {
  description = "Debug: enabled at root"
  value       = var.enabled
}
