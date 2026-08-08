#resource "aws_vpc_endpoint" "this" {
#  count = var.enabled ? 1 : 0

  #vpc_id              = var.vpc_id
  #service_name        = var.service_name
  #vpc_endpoint_type   = "Interface"
  #subnet_ids          = var.subnet_ids
  #security_group_ids  = var.security_group_ids
  #private_dns_enabled = var.private_dns_enabled

  #tags = merge(
   # {
   #   Name      = var.name
   #   ManagedBy = "Terraform"
   # },
   # var.tags
  #)
#}

#output "enabled" {
#  description = "RG Debug: enabled flag inside interface_endpoint module"
#  value       = var.enabled
#}
# =========================================================
# 1. THE ELASTIC IP LIFECYCLE (The IP Address Itself)
# =========================================================

# Tell Terraform to import your existing AWS Elastic IP allocation
import {
  to = aws_eip.endpoint_static_ip
  id = "eipalloc-0123456789abcdef0" # <-- Replace with your real EIP Allocation ID
}

# Define the IP resource so Terraform can create/delete it
resource "aws_eip" "endpoint_static_ip" {
  domain = "vpc" # Confirms this IP belongs inside a VPC network context

  # Optional: You can manage your AWS tags right here
  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# =========================================================
# 2. THE ASSOCIATION (The Link Between IP and Interface)
# =========================================================

# Tell Terraform to import your existing mapping link
import {
  to = aws_eip_association.vpc_endpoint_eip
  id = "eipassoc-047f58c615db714ef"
}

# Define the connection link using a dynamic dependency reference
resource "aws_eip_association" "vpc_endpoint_eip" {
  network_interface_id = "eni-0ec9e9b0df56329de"
  
  # This chains the association directly to the IP managed above
  allocation_id        = aws_eip.endpoint_static_ip.id
}
