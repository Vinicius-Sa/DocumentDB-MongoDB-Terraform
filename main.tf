resource "aws_docdb_cluster" "default" {
  cluster_identifier           = "${var.cluster_name}-docdb"
  master_username              = var.master_username
  master_password              = var.master_password
  backup_retention_period      = var.retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  skip_final_snapshot          = var.skip_final_snapshot
  deletion_protection          = var.deletion_protection
  apply_immediately            = var.apply_immediately
  storage_encrypted            = var.storage_encrypted
  kms_key_id                   = var.kms_key_id
  port                         = var.db_port
  snapshot_identifier          = var.snapshot_identifier
  vpc_security_group_ids       = var.vpc_security_group_ids
  db_subnet_group_name         = aws_docdb_subnet_group.default.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.docdb.name
  engine                          = var.engine
  engine_version                  = var.engine_version
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags                            = merge(var.tags, { Name = var.resource })
}

resource "aws_docdb_cluster_instance" "default" {
  count              = var.instance_number
  cluster_identifier = aws_docdb_cluster.default.id
  identifier         = "${var.cluster_name}-${count.index}"
  apply_immediately  = var.apply_immediately
  instance_class     = var.instance_type
  engine             = var.engine
  tags               = merge(var.tags, { Name = var.resource })
}

resource "aws_docdb_subnet_group" "default" {
  name        = "docdb_subnet_group-${var.environment}"
  description = "Allowed subnets for DB cluster instances"
  subnet_ids  = var.subnet_ids
  tags        = merge(var.tags, { Name = var.resource })
}

resource "aws_docdb_cluster_parameter_group" "docdb" {
  name        = "docdb-parameter-group-${var.environment}"
  family      = var.family
  description = "docdb cluster parameter group"

  parameter {
    name  = "tls"
    value = "disabled"
  }
}
