enabled             = true
region              = "us-east-1"
vpc_id              = "vpc-0c4f804e905f41635"
subnet_ids          = ["subnet-0e2edd5fa0e3907f0"]
security_group_ids  = ["sg-02c3be99d2bc862ca"]
service_name        = "com.amazonaws.us-east-1.ec2messages"
private_dns_enabled = true

tags = {
  Name      = "ec2messages-interface-endpointRGT"
  ManagedBy = "TerraformRGT"
  Service   = "ec2messagesRGT"
}
