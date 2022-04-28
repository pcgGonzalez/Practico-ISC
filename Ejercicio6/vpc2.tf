resource "aws_vpc" "test-terraform-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.test-terraform-vpc.id
    tags = {
        Name = "igwpruebatf2" 
    }
  
}

resource "aws_subnet" "g9subnet1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.test-terraform-vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnetg91-ue1a"
  }
}

resource "aws_subnet" "g9subnet2" {
  cidr_block = "10.0.2.0/24"
  vpc_id = aws_vpc.test-terraform-vpc.id
  availability_zone = "us-east-1b"
  tags = {
    Name = "subnetg92-ue1b"
  }
}

resource "aws_route_table" "g9route_table" {
    vpc_id = aws_vpc.test-terraform-vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }
    
}


resource "aws_network_interface" "interfaces-NGNX1" {
  subnet_id   = aws_subnet.g9subnet1.id
  private_ips = ["10.0.1.15"]

  tags = {
    Name = "primary_network_interface"
  }
}
  

resource "aws_network_interface" "interfaces-NGNX2" {
  subnet_id   = aws_subnet.g9subnet1.id
  private_ips = ["10.0.1.16"]

  tags = {
    Name = "primary_network_interface"
  }
}
  