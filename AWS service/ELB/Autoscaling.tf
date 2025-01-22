resource "aws_launch_configuration" "launch-config" {
  image_id = lookup(var.AMIS, var.aws-region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name
  name_prefix   = "launch-config"
  security_groups = [aws_security_group.sg-instance.id]
  user_data     = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Team\nThis is my IP: '$MYIP > /var/www/html/index.html"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "levelup_key" {
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_autoscaling_group" "autoscaling" {
  max_size                  = 2
  min_size                  = 2
  name                      = "autoscaling"
  vpc_zone_identifier = [aws_subnet.vpc-public-1.id, aws_subnet.vpc-public-2.id]
  health_check_grace_period = 200
  health_check_type         = "EC2"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch-config.name
  load_balancers = [aws_elb.elb.name]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "Custom ec2 instance"
  }
}

output "ELB" {
  value = aws_elb.elb.dns_name
}