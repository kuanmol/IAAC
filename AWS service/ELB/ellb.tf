resource "aws_elb" "elb" {
  name = "elb"
  subnets = [aws_subnet.vpc-public-1.id, aws_subnet.vpc-private-2.id]
  security_groups = [aws_security_group.sg-elb.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    interval            = 30
    target              = "HTTP:80/"
    timeout             = 3
    unhealthy_threshold = 2
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "elb"
  }
}

resource "aws_security_group" "sg-elb" {
  vpc_id      = aws_vpc.custom-vpc.id
  name        = "elb-sg"
  description = "sg for elastic load balancer"

  egress {
    from_port = 0
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol  = "-1"
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "elb-sg"
  }
}

resource "aws_security_group" "sg-instance" {
  vpc_id      = aws_vpc.custom-vpc.id
  name        = "instance"
  description = "sg for instance"

  egress {
    from_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    to_port   = 0
    protocol  = "-1"
  }
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = [aws_security_group.sg-elb.id]
  }
  tags = {
    Name = "instancec"
  }
}















