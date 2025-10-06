resource "random_password" "db_password" {
  length  = 24
  special = true
}

resource "aws_secretsmanager_secret" "db" {
  name = "${var.project}/db"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
    dbname   = var.db_name
  })
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-dbsubnet"
  subnet_ids = [for _, s in aws_subnet.private_db : s.id]
}

resource "aws_db_instance" "postgres" {
  identifier            = "${var.project}-pg"
  engine                = "postgres"
  engine_version        = "16.2"
  instance_class        = "db.t4g.micro"
  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  multi_az                   = false
  publicly_accessible        = false
  storage_encrypted          = true
  backup_retention_period    = 3
  deletion_protection        = false
  skip_final_snapshot        = true
  auto_minor_version_upgrade = true

  apply_immediately = true
}
