output "hello_kaotik" {
	value = "Hello, KaotiK!"
}

output "vpc_id" {
  value       = data.aws_vpc.selected.id
}

output "aws_instance_public_dns" {
  value = aws_instance.webserver.public_dns
}

output "aws_instance_private_ip" {
  value = "${aws_instance.webserver.private_ip}"
}

output "aws_instance_public_elastic_ip" {
  value = "${aws_eip.webserver.public_ip}"
}
