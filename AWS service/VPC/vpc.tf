terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
resource "aws_vpc" "custom-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_classiclink   = "false"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = "custom-vpc"
  }
}