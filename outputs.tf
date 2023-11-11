output "hello_kaotik" {
	value = "Hello, KaotiK!"
}

output "vpc_name" {
  description = "ID of the VPC"
  value       = data.aws_vpc.selected.id
}
