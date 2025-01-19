resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.custom-vpc.id
  name        = "allow-ssh"
  description = "sg allow ssh"
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow--ssh"
  }
}

resource "aws_security_group" "allow-mariadb" {
  vpc_id      = aws_vpc.custom-vpc.id
  name        = "allow-mariadb"
  description = "sg allow maria"
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"
    security_groups = [aws_security_group.allow-ssh.id]
  }
  tags = {
    Name = "allow--maria"
  }
}