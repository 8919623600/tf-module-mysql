#provision mqsql

resource "aws_db_instance" "mysql" {
  identifier             = "Roboshop-${var.ENV}-mysql"
  instance_class         = var.MYSQL_INSTANCE_CLASS
  allocated_storage      = var.MYSQL_STORAGE
  engine                 = var.MYSQL_ENGINE
  engine_version         = var.MYSQL_VERSION
  username               = "admin1"
  password               = "RoboShop1"
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
  parameter_group_name   = aws_db_parameter_group.mysql.name
  skip_final_snapshot    = var.MYSQL_SKIP_FINAL_SNAPSHOT
}

# Provisons Parameter Groups for RDS
resource "aws_db_parameter_group" "mysql" {
  name                = "rds-pg"
  family              = var.MYSQL_ENGINE_FAMILY
}

# Provisions Subnet Group
resource "aws_db_subnet_group" "mysql" {
  name                = "roboshop-${var.ENV}-mysql"
  subnet_ids          = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS

  tags = {
    Name = "roboshop-${var.ENV}-mysql"
  }
}



