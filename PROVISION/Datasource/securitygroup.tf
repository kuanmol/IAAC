data "aws_ip_ranges" "us-east-ip-range" {
  regions = ["us-west-1", "us-west-2"]
  services = ["ec2"]
}

resource "aws_security_group" "sg_custom-us-west" {
  name = "sg_custom-us-west"
  ingress {
    from_port = "443"
    to_port   = "443"
    protocol  = "tcp"
    cidr_blocks = slice(data.aws_ip_ranges.us-east-ip-range.cidr_blocks, 0, 50) # Limit to 50 CIDR blocks

  }
  tags = {
    CrateData = data.aws_ip_ranges.us-east-ip-range.create_date
    SyncToken = data.aws_ip_ranges.us-east-ip-range.sync_token
  }
}