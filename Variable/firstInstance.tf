resource "aws_instance" "MyFirstInstance" {
  ami = lookup(var.AMIS, var.aws-region)
  instance_type = "t2.micro"

  tags = {
    Name = "instances"  //new name
  }

  security_groups = "${var.Security_group}"
}