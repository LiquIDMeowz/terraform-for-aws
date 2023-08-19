# Scale on 'x' Request @ #10
resource "aws_cloudwatch_metric_alarm" "lb-requests" {
  alarm_name          = "LB Requests"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "RequestCount"
  namespace           = "AWS/ELB"
  period              = "60"
  statistic           = "Sum"
  threshold           = "5"
  alarm_description   = "Requests Breach"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [aws_autoscaling_policy.web_policy_up.arn]
  ok_actions          = [aws_autoscaling_policy.web_policy_down.arn]
  dimensions = {
    LoadBalancerName = aws_elb.webelb.name
  }
}