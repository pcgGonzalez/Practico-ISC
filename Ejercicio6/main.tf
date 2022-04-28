provider "aws" {
  profile = "default"
  region  = "us-east-1"
}



resource "aws_instance" "despliegue-terraform-ec2-NGNX1" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.test-terraform-sg-ngnx.id]
  subnet_id = aws_subnet.g9subnet1.id
  network_interface {
    network_interface_id=aws_network_interface.interfaces-NGNX1.id
    device_index = 0
  }
  tags = {
    Name = "NGNX1"
  }


}

resource "aws_instance" "despliegue-terraform-ec2-NGNX2" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.test-terraform-sg-ngnx.id]
  subnet_id = aws_subnet.g9subnet1.id
  network_interface {
    network_interface_id=aws_network_interface.interfaces-NGNX2.id
    device_index = 0
  }

  tags = {
    Name = "NGNX2"
  }


}

resource "aws_instance" "despliegue-terraform-ec2-WP" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.instance-ngnx-sg.id]
  subnet_id = aws_subnet.g9subnet2.id

  tags = {
    Name = "WORDPRESS"
  }


}

