# Create database instance
resource "aws_db_instance" "project_db" {
  allocated_storage           = 5
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7"
  instance_class              = "db.t2.micro"
  identifier                  = "db-instance"
  db_name                     = "project_db"
  username                    = "admin"
  password                    = "password"
  db_subnet_group_name        = "db_subnetgroup"
  allow_major_version_upgrade = true
  auto_minor_version_upgrade  = true
  backup_retention_period     = 35
  backup_window               = "22:00-23:00"
  maintenance_window          = "Sat:00:00-Sat:03:00"
  multi_az                    = false
  vpc_security_group_ids      = [aws_security_group.private_sg.id]
  publicly_accessible         = false
  skip_final_snapshot         = true
}