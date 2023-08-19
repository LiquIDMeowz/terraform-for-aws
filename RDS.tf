# SG for RDS Instance on 3306 accessible only from EC's in "allow_conn" SG @ #10
resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow traffic from allow_conn SG"
  vpc_id      = aws_vpc.ec2_vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_conn.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Allow Traffic from allow_conn SG"
  }
}

# Subnet group to associate correct VPC by subnet_ids @ #27-30
resource "aws_db_subnet_group" "rds_subgroup" {
  name        = "rds_subgroup"
  description = "Sub-Group for RDS and VPC correlation"
  subnet_ids = [
    aws_subnet.public_eu_central_1a.id,
    aws_subnet.public_eu_central_1b.id,
    aws_subnet.public_eu_central_1c.id
  ]
  tags = {
    Name = "Sub-Group for RDS and VPC correlation"
  }
}

# RDS Database Instance under custom subnet group @ #47 to associate correct VPC - no public access @ #50
resource "aws_db_instance" "rds" {
  engine                 = "mysql"
  identifier             = "rdsinstance"
  allocated_storage      = 20
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  username               = var.rds_user
  password               = var.rds_password
  parameter_group_name   = "default.mysql5.7"
  db_subnet_group_name   = aws_db_subnet_group.rds_subgroup.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
}

# Out the RDS endpoint for easier access
output "db_instance_endpoint" {
  value = aws_db_instance.rds.endpoint
}