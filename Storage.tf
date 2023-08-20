# EFS
resource "aws_efs_file_system" "file_system_1" {
  creation_token   = "efs-test"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}


# Mount Target for public_eu_central_1a
resource "aws_efs_mount_target" "mount_target_1" {
  count           = 1
  file_system_id  = aws_efs_file_system.file_system_1.id
  subnet_id       = aws_subnet.public_eu_central_1a.id
  security_groups = [aws_security_group.allow_conn.id]
}

# Mount Target for public_eu_central_1b
resource "aws_efs_mount_target" "mount_target_2" {
  count           = 1
  file_system_id  = aws_efs_file_system.file_system_1.id
  subnet_id       = aws_subnet.public_eu_central_1b.id
  security_groups = [aws_security_group.allow_conn.id]
}

# Mount Target for public_eu_central_1c
resource "aws_efs_mount_target" "mount_target_3" {
  count           = 1
  file_system_id  = aws_efs_file_system.file_system_1.id
  subnet_id       = aws_subnet.public_eu_central_1c.id
  security_groups = [aws_security_group.allow_conn.id]
}