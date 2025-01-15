provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

resource "aws_instance" "MyFirstInstance" {
  ami           = "ami-0c7af5fe939f2677f"
  instance_type = "t2.micro"
}