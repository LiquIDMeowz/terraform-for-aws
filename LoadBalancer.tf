# Define Load Balancer configuration and listener under custom subnets @ #7-10
resource "aws_elb" "webelb" {
  name = "webelb"
  security_groups = [
    aws_security_group.elb_allow_conn.id
  ]
  subnets = [
    aws_subnet.public_eu_central_1a.id,
    aws_subnet.public_eu_central_1b.id,
    aws_subnet.public_eu_central_1c.id
  ]
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

# Echo the domain for direct access
output "elb_dns_name" {
  value = aws_elb.webelb.dns_name
}
