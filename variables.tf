variable "default_tags" {
  type        = map(any)
  default     = {}
  description = "Tags definition."
}

variable "allowed_security_groups" {
  type        = list(string)
  default     = [] #Passar a lista de sg com ingress permission
  description = "List of existing Security Groups to be allowed to connect to the DocumentDB cluster"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = [] #Passar a lista de cidr blocks com ingress permission
  description = "List of CIDR blocks to be allowed to connect to the DocumentDB cluster"
}

variable "master_username" {
  type        = string
  default     = "admin1"
  description = "(Required unless a snapshot_identifier is provided) Username for the master DB user"
}

variable "master_password" {
  type        = string
  default     = "b7htC2S21$zD"
  description = "Password for the master DB user (Required unless a snapshot_identifier is provided) "
}

variable "retention_period" {
  type        = number
  default     = 1
  description = "Number of days to retain backups for"
}

variable "preferred_backup_window" {
  type        = string
  default     = "07:00-09:00"
  description = "Daily time range during which the backups happen"
}

variable "preferred_maintenance_window" {
  type        = string
  default     = "Mon:22:00-Mon:23:00"
  description = "The window to perform maintenance in. Syntax: `ddd:hh24:mi-ddd:hh24:mi`."
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted. If true is specified, no DB snapshot is created. If false is specified, a DB snapshot is created before the DB cluster is deleted "
  default     = true
}

variable "deletion_protection" {
  type        = bool
  description = "A value that indicates whether the DB cluster has deletion protection enabled"
  default     = true
}

variable "storage_encrypted" {
  type        = bool
  description = "Specifies whether the DB cluster is encrypted"
  default     = false
}

variable "kms_key_id" {
  type        = string
  description = "The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true`"
  default     = ""
}

variable "db_port" {
  type        = number
  default     = 27017
  description = "DocumentDB port"
}

variable "snapshot_identifier" {
  type        = string
  default     = ""
  description = "Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot"
}

variable "region" {
  type = string
}

variable "resource" {
  type        = string
  description = "The replication group identifier. This parameter is stored as a lowercase string."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of VPC subnet IDs to place DocumentDB instances in"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to create the cluster in"
}


variable "description" {
  type        = string
  description = "The replication group identifier. This parameter is stored as a lowercase string."
}

variable "tags" {
  default     = {}
  type        = map(any)
  description = "A mapping of tags to assign to all resources."
}

variable "environment" {
  type        = string
  description = "Name of environment, Dev, prod, stg, tst, etc"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "List of log types to export to cloudwatch. The following log types are supported: `audit`, `error`, `general`, `slowquery`"
  default     = []
}

variable "instance_type" {
  type        = string
  description = "DocDB cluster instance type" # https://docs.aws.amazon.com/documentdb/latest/developerguide/limits.html#suported-instance-types
  default     = "db.t3.medium"
}

variable "engine" {
  type        = string
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Defaults to docdb"
}

variable "engine_version" {
  type        = string
  default     = "4.0" #Discutir com time
  description = "The version number of the database engine to use"
}

variable "cluster_name" {
  type        = string
  description = "Instance count for docdb cluster"
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  default     = true
}

variable "instance_number" {
  type        = number
  description = "The number of resources will be created"
  default     = "1"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability_zones, us-west-2a, us-west"
}
variable "vpc_security_group_ids"{
  type        = list
  description = "List of VPC security groups to associate with the Cluster"
}

variable "family"{
  type        = string
  description = "The family of the documentDB cluster parameter group."
}

#variable "parameters" {
#  description = "additional parameters modified in parameter group"
#  type        = list(map(any))
#  default     = []
#}