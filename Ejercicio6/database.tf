resource "aws_db_instance" "education" {
  identifier             = "education"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = "edu"
  password               = "Administrator"
  db_subnet_group_name  = aws_db_subnet_group.subnetgroupg9.id
  vpc_security_group_ids = [aws_security_group.instance-ngnx-sg.id]
  #parameter_group_name  = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}

resource "aws_db_subnet_group" "subnetgroupg9" {
  name       = "main"
  subnet_ids = [aws_subnet.g9subnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}