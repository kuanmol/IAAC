resource "aws_launch_configuration" "launch-config" {
  image_id = lookup(var.AMIS, var.aws-region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name
  name_prefix   = "launch-config"
}

resource "aws_key_pair" "levelup_key" {
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_autoscaling_group" "autoscaling" {
  max_size                  = 2
  min_size                  = 1
  name                      = "autoscaling"
  vpc_zone_identifier = ["us-east-1a", "us-east-1b"]
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch-config.name

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "Custom ec2 instance"
  }
}

resource "aws_autoscaling_policy" "cpu-policy" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  name                   = "cpu-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "cpu-alaram" {
  alarm_name          = "cpu-alaram"
  alarm_description   = "Alaram once Cpu uses increase"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.cpu-policy.arn]
}

resource "aws_autoscaling_policy" "cpu-policy-scaledown" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  name                   = "cpu-policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "200"
  policy_type            = "SimpleScaling"
}


resource "aws_cloudwatch_metric_alarm" "cpu-alaram-scaledown" {
  alarm_name          = "cpu-alaram"
  alarm_description   = "Alaram once Cpu uses decrease"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.cpu-policy-scaledown.arn]
}
