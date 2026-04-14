resource "aws_vpc_endpoint" "this" {
  count = var.enabled ? 1 : 0

  vpc_id              = var.vpc_id
  service_name        = var.service_name
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids
  security_group_ids  = var.security_group_ids
  private_dns_enabled = var.private_dns_enabled

  tags = merge(
    {
      Name      = var.name
      ManagedBy = "Terraform"
    },
    var.tags
  )
}

output "enabled" {
  description = "Debug: enabled flag inside interface_endpoint module"
  value       = var.enabled
}
