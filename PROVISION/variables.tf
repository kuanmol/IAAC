variable "access-key" {}
variable "secret-key" {}
variable "aws-region" {
  default = "us-east-1"
}
variable "Security_group" {
  type = list
  default = ["sg-34534", "sg-34554", "sg-98765"]
}
variable "AMIS" {
  type = map
  default = {
    us-east-1 = "ami-0b0ea68c435eb488d"
    us-east-2 = "ami-05803413c51f242b7"
    us-west-1 = "ami-0454207e5367abf01"
    us-west-2 = "ami-01c0540df77ccaa68"

  }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}