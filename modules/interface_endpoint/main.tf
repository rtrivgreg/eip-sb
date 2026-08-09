#resource "aws_vpc_endpoint" "this" {
  count = var.enabled ? "t3.medium" : "t3.nano"

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

resource "aws_instance" "example" {  
  instancetype          = var.instancetype  #nano
  ami                    = "ami-0c55b159cbfafe1f"  
  #vpcsecuritygroupids = var.securitygroups  
  #associatepublicipaddress = var.publicip != "" ? true : false  
}