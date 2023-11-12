#---------------------------------------------------------------------------------------------------
# General
#---------------------------------------------------------------------------------------------------

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    Terraform = "true"
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
  default     = ""
}

variable "instance_type" {
  description = "Instance Type for shared ec2"
  type = string
  default = "t2.micro"
}
