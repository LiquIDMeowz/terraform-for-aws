# Amazon Image
variable "ami_id" {
  description = "Amazon Image"
  default     = "ami-0c4c4bd6cf0c5fe52"
}

# Declare Username variable for RDS
variable "rds_user" {
  description = "RDS Username"
  default     = "liquidmeow"
}

# Declare Password variable for RDS
variable "rds_password" {
  description = "RDS Password"
  default     = "liquidmeow"
}
