data "aws_availability_zones" "available" {}

locals {
    name_prefix    = "${var.application}-${var.environment}"
    region = var.region
    azs      = slice(data.aws_availability_zones.available.names, 0, 3)
    tags = var.tags
}
