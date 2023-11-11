output "hello_kaotik" {
	value = "Hello, KaotiK!"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = try(data.aws_vpc.selected[0].name, aws_vpc.this[0].name)
}
