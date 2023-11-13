#---------------------------------------------------------------------------------------------------
# General
#---------------------------------------------------------------------------------------------------
variable "application" {
  description = "application name"
  default = "<replace_with_your_project_or_application_name, use short name if possible, because some resources have length limit on its name>"
}

variable "environment" {
  description = "environment name"
  default = "<replace_with_environment_name, such as dev, svt, prod,etc. Use short name if possible, because some resources have length limit on its name>"
}

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
