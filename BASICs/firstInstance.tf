resource "aws_instance" "MyFirstInstance" {

  count = 3  //for multiple instance at once
  ami           = "ami-0c7af5fe939f2677f"
  instance_type = "t2.micro"
  tags = {
    Name = "three-instances-${count.index}"  //new name to each instance
  }
}