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

resource "aws_instance" "webserver" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = var.key_name
  user_data              = file("userdata.sh")

  instance_type          = var.instance_type

  vpc_security_group_ids = [aws_security_group.internet-access.id]
  availability_zone = element(local.azs, 0)
  subnet_id              = sort(data.aws_subnets.all.ids)[0]
  #subnet_id              = sort(data.aws_subnets.all.ids)[0].id
  #subnet_id              = data.aws_subnets.all[0].id

  root_block_device {
    volume_size    = 8
    volume_type    = "gp2"
    tags = merge(local.tags,{
      Name = "${local.name_prefix}-webserver-root"
      },
    )

  }

  tags = merge(local.tags,{
        Name = "${local.name_prefix}-webserver"
        },
    )
}

resource "aws_ebs_volume" "webserver-data" {
  availability_zone = aws_instance.webserver.availability_zone
  size              = 21
  # encryption TODO

  tags = merge(local.tags,{
    Name = "${local.name_prefix}-webserver-data"
    },
  )
}

resource "aws_volume_attachment" "webserver-data" {
  device_name = "/dev/sdd"
  volume_id   = aws_ebs_volume.webserver-data.id
  instance_id = aws_instance.webserver.id
  force_detach = true
}

resource "aws_eip" "webserver" {
  instance = aws_instance.webserver.id
  domain = "vpc"
}

resource "aws_security_group" "internet-access" {
  name        = "${local.name_prefix}-internet-access"
  description = "allow ssh on 22 + http/https on port 80/443"
  vpc_id      = data.aws_vpc.vpc.id

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
