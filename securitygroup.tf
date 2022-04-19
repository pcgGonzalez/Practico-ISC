resource "aws_security_group" "test-terraform-sg" {
  name	 = "test-terraform-sg"
  vpc_id = "vpc-0e97f0e6c9224fd5c"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

