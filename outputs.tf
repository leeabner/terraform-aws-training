output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ubuntu01.id
}

output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.ubuntu01.public_ip
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}
