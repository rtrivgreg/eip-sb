# Instance Type begin
variable "instance_id" {  
  type = string  
  description = "The ID of the EC2 instance."  
}  
variable "instance_type" {  
  type = string  
  description = "The desired instance type, e.g., t2.micro."  
}  
#Instance Type end

variable "enabled" {
  type        = bool
  description = "Whether to create/manage the endpoint"
  default     = true
}

variable "name" {
  type        = string
  description = "Name tag for the endpoint"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "service_name" {
  type        = string
  description = "Service name"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs"
}

variable "private_dns_enabled" {
  type        = bool
  description = "Enable private DNS"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Extra tags"
  default     = {}
}