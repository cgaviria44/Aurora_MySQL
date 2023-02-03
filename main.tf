resource "aws_rds_cluster" "aurora_cluster" {
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.2.10.2"
  storage_encrypted            = true 
  cluster_identifier           = var.name
  master_username              = "master"
  master_password              = "Admin1235cs"
  availability_zones           = ["${var.region}a", "${var.region}b"]
  vpc_security_group_ids       = [aws_security_group.rdssg.id]
  db_subnet_group_name         = "${aws_db_subnet_group.aurora_subnet_group.name}"
  database_name                = var.name
  backup_retention_period      = 7
  preferred_backup_window      = "23:59-02:00"
  skip_final_snapshot          = true
  enable_http_endpoint         = true
  preferred_maintenance_window = "sat:03:00-sat:04:00"
  deletion_protection          = false
  #final_snapshot_identifier     = "final-snapshot"

  tags = {
  Name      = var.name
  Env       = var.Environment
  Terraform = "True"
}
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-${count.index}" 
  cluster_identifier = aws_rds_cluster.aurora_cluster.id
  instance_class     = var.instance_type
  engine             = aws_rds_cluster.aurora_cluster.engine
  engine_version     = aws_rds_cluster.aurora_cluster.engine_version
}

resource "aws_db_subnet_group" "aurora_subnet_group" {
  name        = "${var.name}_aurora_db_subnet_group"
  description = "Allowed subnets for Aurora DB cluster instances"
  subnet_ids  = var.vpc_rds_subnet_ids
}

resource "aws_security_group" "rdssg" {
    name   = "rdssg"
    vpc_id =  var.vpc_id

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = var.private_subnets

    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}