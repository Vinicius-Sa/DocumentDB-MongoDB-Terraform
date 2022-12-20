#output "aws_db_subnet_group_id" {
#  value       = aws_db_subnet_group.default.id
#  description = "The ID of the subnet group"
#}

#output "vpc_security_group_ids" {
#  value       = aws_security_group.db.id
#  description = "The ID of the VPC security group"
#}

output "aws_security_group_id" {
  value       = aws_security_group.ecs_sg.id
}

output "aws_security_group_docdb_id" {
  value       = aws_security_group.docdb_sg.id
}


output "vpc_security_group_ecs_ids" {
  value       = aws_security_group.ecs_sg.id
  description = "The ID of the ECS security group"
}

output "aws_pub_subnet_id" {
  value       = aws_subnet.public_subnet_a.id
  description = "The ID of public subnet"
}

output "aws_pri_subnet_id" {
  value       = aws_subnet.private_subnet_a.id
  description = "The ID of public subnet"
}

output "id_vpc" {
  value       = aws_vpc.main.id
  description = "The id of VPC"
}

output "subnets_id" {
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]
}

output "aws_all_subnets_id" {
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id,
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}

output "aws_all_subnets_id_public" {
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
}


output "aws_all_subnets_id_private" {
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id,
  ]
}

output "aws_all_subnets_az" {
  value = [
    aws_subnet.private_subnet_a.availability_zone,
    aws_subnet.private_subnet_b.availability_zone,
  ]
}
