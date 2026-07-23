output "instance_id_ubuntu" {
  description = "Ubuntu instance ID"
  value       = aws_instance.ubuntu01.id
}

output "public_ip_ubuntu" {
  description = "Public IP of the Ubuntu instance"
  value       = aws_instance.ubuntu01.public_ip
}

output "instance_id_amazon_linux" {
  description = "Amazon Linux instance ID"
  value       = aws_instance.amazon_linux01.id
}

output "public_ip" {
  description = "Public IP of the Amazon Linux instance"
  value       = aws_instance.amazon_linux01.public_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
