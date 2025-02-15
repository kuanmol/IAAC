data "aws_availability_zones" "avialable" {}
//fetch all zones and put in the aviable variable

resource "aws_instance" "Instance" {
  ami = lookup(var.AMIS, var.aws-region)
  instance_type     = "t2.micro"
  availability_zone = data.aws_availability_zones.avialable.names[1] // it like json data and choose zones frm list (b)

  provisioner "local-exec" {
    command = "echo aws_instance.Instance.private_ip >> my_private_ips.txt"
  }

  tags = {
    Name = "customised"
  }
}
output "public_ip" {
  value = aws_instance.Instance.public_ip
}

