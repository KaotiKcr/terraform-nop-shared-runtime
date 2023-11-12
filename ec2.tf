# DATA

data "aws_ami" "aws_ubuntu" {
  most_recent = true
  owners      = ["amazon"]

 filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# RESOURCES

resource "aws_eip" "shared_kaotik" {
  instance = "${aws_instance.shared_kaotik.id}"
  domain = "vpc"
}

resource "aws_instance" "shared_kaotik" {
  instance_type          = var.instance_type
  ami                    = "ami-052efd3df9dad4825"
  key_name               = var.key_name
  user_data              = file("userdata.sh")
  tags = var.tags
}

resource "aws_security_group" "shared_web" {
  name        = "shared_web"
  description = "allow ssh on 22 & http/s on port 80/443"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
