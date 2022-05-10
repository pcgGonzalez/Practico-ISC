provider "aws" {
  profile = "default"
  region  = "us-east-1"
}





resource "aws_instance" "NGNX1" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.security_group_ngnx.id]
  subnet_id = aws_subnet.g9_subnet_1.id
#  network_interface {
#    network_interface_id=aws_network_interface.interfaces-NGNX1.id
#    device_index = 0
#  }
  tags = {
    Name = "NGNX1"
  }


}

resource "aws_instance" "NGNX2" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.security_group_ngnx.id]
  subnet_id = aws_subnet.g9_subnet_2.id
#  network_interface {
#    network_interface_id=aws_network_interface.interfaces-NGNX2.id
#    device_index = 0
#  }

  tags = {
    Name = "NGNX2"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/lucas/labsuser.pem")
    host        = self.public_ip
  }
  

    provisioner "file" {
     source = "./ngnx.conf"
     destination = "/home/"
    #   connection {
    #    type        = "ssh"
    #    user        = "ec2-user"
    #    private_key = file("/home/lucas/labsuser.pem")
    #    host        = self.public_ip
    #    }
     }


  provisioner "remote-exec" {
    inline = [
      "sudo yum install epel-release",
      "sudo yum update",
      "sudo yum install -y nginx",
      "sudo unlink /etc/nginx/sites-enabled/default",
      "mv /home/ngnx.conf /etc/nginx/sites-available/",
      "sudo ln -s /etc/nginx/sites-available/ngnx.conf /etc/nginx/sites-enabled/ngnx.conf",
      "sudo rm /etc/nginx/sites-enabled/default",
      "sudo systemctl reload nginx",
      "sudo systemctl enable ngnx",
      "sudo systemctl start ngnx",
    ]
  }



}

resource "aws_instance" "WordPress" {
  ami                    = "ami-015ebb80abc548b7f"
  instance_type          = "t2.micro"
  key_name      	       = "vockey"
  vpc_security_group_ids = [aws_security_group.security_group_wordpress.id]
  subnet_id = aws_subnet.g9_subnet_3.id

  tags = {
    Name = "WORDPRESS"
  }


}

data "template_file" "init" {
  template = "${file("./ngnx.conf")}"
  vars = {
    consul_address = "${aws_instance.WordPress.private_ip}"
  }
}