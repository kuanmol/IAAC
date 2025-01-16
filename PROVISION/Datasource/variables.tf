variable "access-key" {
  type    = string
  default = "AKIASXISNCZXFJMZ5B7T"
}
variable "secret-key" {}
variable "aws-region" {
  default = "us-west-1"
}

variable "AMIS" {
  type = map
  default = {
    us-west-1 = "ami-004374a3d56f732a6"
  }
}
