# Auto Scale Group
resource "aws_autoscaling_group" "web" {
  name             = "${aws_launch_configuration.web.name}-asg"
  min_size         = 2
  desired_capacity = 2
  max_size         = 3

  health_check_type = "ELB"
  load_balancers = [
    aws_elb.webelb.id
  ]
  launch_configuration = aws_launch_configuration.web.name
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
  vpc_zone_identifier = [
    aws_subnet.public_eu_central_1a.id,
    aws_subnet.public_eu_central_1b.id,
    aws_subnet.public_eu_central_1c.id
  ]
  # Lifecycle - should wait for new instance init before shutting down previous? 
  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}


# Define scale-up policy
resource "aws_autoscaling_policy" "web_policy_up" {
  name                   = "web_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}

# Define scale-down policy
resource "aws_autoscaling_policy" "web_policy_down" {
  name                   = "web_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.web.name
}
