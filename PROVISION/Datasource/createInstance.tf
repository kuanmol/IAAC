resource "aws_instance" "Instance" {
  ami = lookup(var.AMIS, var.aws-region)
  instance_type = "t2.micro"

  tags = {
    Name = "customised"
  }
}