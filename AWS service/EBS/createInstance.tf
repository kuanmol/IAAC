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

  tags = {
    Name = "customised"
  }
}

#ebs
resource "aws_ebs_volume" "vol-1" {
  availability_zone = "us-east-1a"
  size              = 50
  type              = "gp2"
  tags = {
    Name = "VOLUME DISK"
  }
}

#attachment

resource "aws_volume_attachment" "vol-1-attachment" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.Instance.id
  volume_id   = aws_ebs_volume.vol-1.id
}












