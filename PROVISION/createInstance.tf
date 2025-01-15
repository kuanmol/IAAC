resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "Instance" {
  ami           = lookup(var.AMIS, var.aws-region)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.levelup_key.key_name

  tags = {
    Name = "customised"
  }

  provisioner "file" {
    source      = "ngnix.sh"  # Adjust path as needed
    destination = "/tmp/ngnix.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Starting script execution...'",
      "chmod +x /tmp/ngnix.sh",
      "sudo sed -i -e 's/\r$//' /tmp/ngnix.sh",
      "echo 'Running nginx setup...'",
      "sudo /tmp/ngnix.sh",
      "echo 'Script finished execution.'"
    ]
  }

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}
