resource "aws_security_group" "tfWebSrvSG" {
  name        = "tfWebSrvSG"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = "${aws_vpc.tfVPC.id}"

  ingress {
    description = "Allow HTTP" 
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"     
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
