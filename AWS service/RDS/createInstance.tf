terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
resource "aws_key_pair" "levelup_key" {
  key_name = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "Instance" {
  ami = lookup(var.AMIS, var.aws-region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name
  availability_zone = "us-east-1a"
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]
  subnet_id = aws_subnet.vpc-public-1.id
  tags = {
    Name = "customised"
  }
}






