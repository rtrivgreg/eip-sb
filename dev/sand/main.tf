resource "aws_instance" "example" {  
 
  ami                   = "ami-0b6c6ebed2801a5cb"  # needs for baseline
  instance_type          = "t3.nano"
  subnet_id             = "subnet-0e2edd5fa0e3907f0"
  security_groups       = ["sg-02c3be99d2bc862ca"]
  key_name              = "TF3"

  #vpcsecuritygroupids = var.securitygroups  
  #associatepublicipaddress = var.publicip != "" ? true : false  
}