resource "aws_security_group" "my_security_group" {
  name        = var.name
  description = "Security group for ECS"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  for_each          = toset([for p in var.ingress_ports : tostring(p)]) # convert numbers to strings
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = var.allowed_cidr
  security_group_id = aws_security_group.my_security_group.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.my_security_group.id
}