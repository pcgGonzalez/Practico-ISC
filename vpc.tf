resource "aws_vpc" "test-terraform-vpc" {
  cidr_block = var.vpc_cidr_block
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.test-terraform-vpc.id
    tags = {
        Name = "igwpruebatf" 
    }
  
}

resource "aws_subnet" "g9subnet" {
  cidr_block = var.subnet_cidr_block1
  vpc_id = aws_vpc.test-terraform-vpc.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "subnetg9-ue1a"
  }
}

resource "aws_route_table" "g9route_table" {
    vpc_id = aws_vpc.test-terraform-vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }
    
}


