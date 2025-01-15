resource "aws_instance" "MyFirstInstance" {

  ami           = "ami-0c7af5fe939f2677f"
  instance_type = "t2.micro"
  tags = {
    Name = "instances"  //new name to each instance
  }
}