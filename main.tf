provider "aws" {
  profile = "default"
  region  = var.region_g9
}



resource "aws_instance" "despliegue-terraform-ec2" {
  ami                    = var.ami_g9
  instance_type          = var.instance_g9
  key_name      	       = var.keyname_g9
  vpc_security_group_ids = [aws_security_group.test-terraform-sg.id]
  subnet_id = aws_subnet.g9subnet.id

  tags = {
    Name = "instance-g9"
  }


}


