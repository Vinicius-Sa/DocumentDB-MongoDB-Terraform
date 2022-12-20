resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.default_tags
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = var.default_tags
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_private_subnet_a
  availability_zone = "${var.region}a"

  tags =merge(var.default_tags, {
    Name = "Terraform private 1a"
  })
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_private_subnet_b
  availability_zone = "${var.region}b"

  tags = merge(var.default_tags,{
    Name = "Terraform private 1b"
  })
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_public_subnet_a
  availability_zone = "${var.region}a"

  tags = merge(var.default_tags,{
    Name = "Terraform public 1a"
  })
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.aws_subnet_public_subnet_b
  availability_zone = "${var.region}b"

  tags = merge(var.default_tags,{
    Name = "Terraform public 1b"
  })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block = var.subnet_infra_legacy
    vpc_peering_connection_id = aws_vpc_peering_connection.main.id
  }


  tags = merge(var.default_tags,{
    Name = "Terraform public_rt"
  })
}

resource "aws_route_table_association" "public_rta_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rta_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rta_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_security_group" "ecs_sg" {
  name        = "terraform-ecs-cluster-sg"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.list_port_service_container
    content {
      from_port    = ingress.value
      to_port      = ingress.value
      protocol     = "tcp"
      cidr_blocks  = ["0.0.0.0/0"]
    }
  }

  egress {
      from_port       = 0
      to_port         = 65535
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags,{
    Name = "Terraform ecs cluster sg"
  })
}

resource "aws_security_group" "docdb_sg" {
  name        = "terraform_documentdb_sg-${var.environment}"
  vpc_id      = aws_vpc.main.id

  ingress {
      from_port    = 27017
      to_port      = 27017
      protocol     = "tcp"
      security_groups = var.aws_service_security_group_ids
  }
  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    cidr_blocks = ["192.168.xx.0/24", "172.16.xx.0/23", "10.10.0.0/24", "10.20.0.0/24"]
  }

  egress {
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = merge(var.default_tags,{
    Name = "Terraform documentdb sg"
  })
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  route {
    cidr_block = var.subnet_infra_legacy
    vpc_peering_connection_id = aws_vpc_peering_connection.main.id
  }
  tags = merge(var.default_tags,{
    Name = "Terraform private_rt"
  })
}

resource "aws_vpc_peering_connection" "main" {
  peer_vpc_id   = var.peer_vpc_id
  vpc_id        = aws_vpc.main.id
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }

  tags          = {
    "Name" = "vpc_qa_to_ecs_${var.environment}"
  }


}
