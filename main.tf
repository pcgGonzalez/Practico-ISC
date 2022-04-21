provider "aws" {
  profile = "default"
  region  = "us-east-1"
}



resource "aws_instance" "despliegue-terraform-ec2" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.test-terraform-sg.id]
  subnet_id = aws_subnet.g9subnet.id

  tags = {
    Name = "instance-g9"
  }


}


