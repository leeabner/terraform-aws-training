data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  additional_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSX8/cKif6Mt+gkhDN1TTCh/D5ZqVsYbbqChpylXm4ySxdb3rCNeVUZZpMSd7pLBarHsJvmcnfis8PnvPWRDo8x8bxb4vxk4nBijFryuwsmlFdrym+Yei5stPUfM+YWRG1vV6iZCtsSDq8OEC9zRS2L1cn/AWGxMNSYurnZhxQ6axD5MAquIYKmScyG0kP/aDnwnXbQ+W071n/wZiZVmnDKuPDvfJ1myxBrCt9dwCk7i7gAPeB3Ds7nuQTpadLtPMYakbUBCPH6m/Yrwpd5prS63hGCieVDsbYePkG0faK1AoalFXj+UiMm1vwfTllqHpIyACQi25pl04DFG9iUrjZRRTC/gIkBe13CA2P3nGpAIaXqmn/T0PlYBmqjqjjnMFG6mwYc2qk3Xf0XEAjTD96QdbARCbQbsZ40GN+G+RrNZi34XnJqf6AThaCmU9kg+lTmT6v/ZZ3c0BySDFoCv5Efp+eEdJOzBy5nY4cB/ZRThEfEh056VbTrIZgpV2qov0QTz/9QuWymCSwYy45Q9+DXnuFYFt6h79TSgU3ftXVzBsinH6OVJXzM3iRtWtStWz/ruYxOEsrr6fjwO7ieYSlRbTnQF57ZPNocKFqDWM1RW9nQexY9B4XID+qPxAkJbc4N+XZnPwYG37M0VCxlNVUlHUkNO9PIJl+xFPTdyrIMw== lee.abner@cibmis.com"
}

resource "aws_instance" "ubuntu01" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = "leeabner-Macbook-Pro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.training.id]

  user_data = <<-EOT
    #!/bin/bash
    key='${local.additional_ssh_public_key}'
    authorized_keys=/home/ubuntu/.ssh/authorized_keys
    grep -qxF "$key" "$authorized_keys" || printf '%s\n' "$key" >> "$authorized_keys"
    chown ubuntu:ubuntu "$authorized_keys"
    chmod 600 "$authorized_keys"
  EOT

  tags = {
    Name = "ubuntu01"
  }
}

resource "aws_instance" "amazon_linux01" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = "leeabner-Macbook-Pro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.training.id]

  user_data = <<-EOT
    #!/bin/bash
    key='${local.additional_ssh_public_key}'
    authorized_keys=/home/ec2-user/.ssh/authorized_keys
    grep -qxF "$key" "$authorized_keys" || printf '%s\n' "$key" >> "$authorized_keys"
    chown ec2-user:ec2-user "$authorized_keys"
    chmod 600 "$authorized_keys"
  EOT

  tags = {
    Name = "amazon_linux01"
  }
}
