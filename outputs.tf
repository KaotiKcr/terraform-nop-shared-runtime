output "hello_kaotik" {
	value = "Hello, KaotiK!"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = data.aws_vpc.selected.id
}

output "aws_instance_public_dns" {
  value = aws_instance.aws_ubuntu.public_dns
}
