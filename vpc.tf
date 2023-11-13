data "aws_vpc" "selected" {
  id = var.vpc_id
}

data "aws_subnets" "default" {
  vpc_id = var.vpc_id
}
