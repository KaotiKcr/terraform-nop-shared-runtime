#---------------------------------------------------------------------------------------------------
# General
#---------------------------------------------------------------------------------------------------

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    ManagedByTerraform = "True"
  }
}

variable "region" {
  description = "The AWS region in which resources are set up."
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "Existing VPC to use."
  type        = string
}

variable "instance_type" {
  description = "Instance Type for shared EC2"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Key pair to be used for SSH to shared EC2."
  type        = string
}
