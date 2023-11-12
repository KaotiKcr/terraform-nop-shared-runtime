output "hello_kaotik" {
	value = "Hello, KaotiK!"
}

output "vpc_id" {
  value       = data.aws_vpc.selected.id
}

output "aws_instance_public_dns" {
  value = aws_instance.shared_kaotik.public_dns
}

output "aws_instance_private_ip" {
  value = "${aws_instance.shared_kaotik.private_ip}"
}

output "aws_instance_public_elastic_ip" {
  value = "${aws_eip.shared_kaotik.public_ip}"
}
