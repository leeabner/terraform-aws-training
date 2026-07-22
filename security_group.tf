resource "aws_security_group" "training" {
  name        = "training"
  description = "Allows SSH access from specific IPs"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "training"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = toset([
    "204.13.100.80/28",
    "173.17.69.247/32",
  ])

  security_group_id = aws_security_group.training.id
  cidr_ipv4         = each.value
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.training.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allow all outbound traffic"
}
