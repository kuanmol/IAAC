resource "aws_db_subnet_group" "mariadb-subnet" {
  name        = "mariadb-subnet"
  description = "rds"
  subnet_ids = [aws_subnet.vpc-private-1.id, aws_subnet.vpc-private-2.id]
}

resource "aws_db_parameter_group" "maria-db-parameter" {
  family      = "mariadb10.5"
  name        = "mariadb-parameter"
  description = "parameter group"
}

resource "aws_db_instance" "mariadb" {
  allocated_storage       = 20
  engine                  = "mariadb"
  engine_version          = "10.5"  # Use a supported MariaDB version
  instance_class          = "db.t3.micro"  # Changed to db.t3.micro
  identifier              = "mariadb"
  username                = "root"
  password                = "mariadb141"
  db_subnet_group_name    = aws_db_subnet_group.mariadb-subnet.name
  parameter_group_name    = aws_db_parameter_group.maria-db-parameter.name
  multi_az                = false
  vpc_security_group_ids  = [aws_security_group.allow-mariadb.id]
  storage_type            = "gp2"
  backup_retention_period = 30
  skip_final_snapshot     = true
}

output "rds" {
  value = aws_db_instance.mariadb.endpoint
}

#mysql -u root -h (endpoint) -P 3306 -p