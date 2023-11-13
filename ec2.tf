# DATA

data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    filter {
        name   = "root-device-type"
        values = ["ebs"]
    }
    owners = ["099720109477"]
}

# RESOURCES

resource "aws_eip" "shared_web" {
  instance = "${aws_instance.shared_web.id}"
  domain = "vpc"
}

resource "aws_instance" "shared_web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  user_data              = file("userdata.sh")

  vpc_security_group_ids = [aws_security_group.shared_web.id]
  #subnet_id              = XXXXXXX --- data.aws_vpc.selected.public_subnets --- "${element(module.vpc.public_subnets,count.index)}"

  tags = merge(var.tags,{
        Name = "${local.name_prefix}-webserver"
        },
    )
}

resource "aws_security_group" "shared_web" {
  name        = "${local.name_prefix}-internet-access"
  description = "allow ssh on 22 + http/https on port 80/443"
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
