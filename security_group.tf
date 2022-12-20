#resource "aws_security_group" "default" {
#  name        = "docdb_cluster_sg_${var.environment}"
#  description = "Security Group for DocumentDB cluster"
#  vpc_id      = var.vpc_id
#  tags        = merge(var.tags, { Name = var.resource })
#
#  ingress {
#    from_port       = var.db_port
#    to_port         = var.db_port
#    protocol        = "tcp"
#    security_groups = var.allowed_security_groups
#  }
#
#  ingress {
#    from_port       = var.db_port
#    to_port         = var.db_port
#    protocol        = "tcp"
#    cidr_blocks = ["192.168.50.0/24", "172.16.10.0/23", "10.10.0.0/24", var.aws_vpc_cidr_block, "10.20.0.0/24"]
#  }
#
#  egress {
#    from_port   = 0
#    to_port     = 0
#    protocol    = "-1"
#    cidr_blocks = ["0.0.0.0/0"]
#  }
#
#  tags = merge(var.tags, { Name = "${var.resource}-docdb" })
#}

#resource "aws_security_group_rule" "egress" {
#  type              = "egress"
#  description       = "Allow all egress traffic"
#  from_port         = 0
#  to_port           = 0
#  protocol          = "-1"
#  cidr_blocks       = ["0.0.0.0/0"]
#  security_group_id = aws_security_group.default.*.id
#}
#
#resource "aws_security_group_rule" "ingress_security_groups" {
#  type                     = "ingress"
#  description              = "Allow inbound traffic from existing Security Groups"
#  from_port                = var.db_port
#  to_port                  = var.db_port
#  protocol                 = "tcp"
#  source_security_group_id = element(var.allowed_security_groups, count.index)
#  security_group_id        = aws_security_group.default.*.id
#}
#
#resource "aws_security_group_rule" "ingress_cidr_blocks" {
#  type              = "ingress"
#  description       = "Allow inbound traffic from CIDR blocks"
#  from_port         = var.db_port
#  to_port           = var.db_port
#  protocol          = "tcp"
#  cidr_blocks       = var.allowed_cidr_blocks
#  security_group_id = aws_security_group.default.*.id
#}