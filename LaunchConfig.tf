# Define launch config for web-server ec's and install required packages @ #7 using external .sh script for reusability
resource "aws_launch_configuration" "web" {
  image_id                    = var.ami_id
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.allow_conn.id]
  associate_public_ip_address = true
  user_data                   = file("script.sh")
  lifecycle {
    create_before_destroy = true
  }
}