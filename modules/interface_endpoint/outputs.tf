output "id" {
  value = var.enabled ? aws_vpc_endpoint.this[0].id : null
}

output "dns_entry" {
  value = var.enabled ? aws_vpc_endpoint.this[0].dns_entry : []
}

output "network_interface_ids" {
  value = var.enabled ? aws_vpc_endpoint.this[0].network_interface_ids : []
}