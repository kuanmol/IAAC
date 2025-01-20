variable "access-key" {
  type    = string
  default = "AKIASXISNCZXFJMZ5B7T"
}

variable "aws-region" {
  default = "us-east-1"
}

variable "secret-key" {}

variable "PATH_TO_PRIVATE_KEY" {
  default = "levelup_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "levelup_key.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"
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