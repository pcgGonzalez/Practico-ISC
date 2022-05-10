#cambiar load balancer a load balancer application alb

#resource "aws_lb" "load-balancer-ngnx" {
#  name               = "instancesdengnx"
#  load_balancer_type = "network"
#  internal = false
#
#  subnet_mapping {
#    subnet_id            = aws_subnet.g9_subnet_1.id
#    private_ipv4_address = "10.0.1.15"
#  }

#  subnet_mapping {
#    subnet_id            = aws_subnet.g9_subnet_2.id
#    private_ipv4_address = "10.0.2.15"
#  }
#}



#resource "aws_lb" "load-balancer-ngnx" {
#  name               = "instancesdengnx"
#  load_balancer_type = "network"

#  subnet_mapping {
#    subnet_id     = aws_subnet.subnet_g91.id
#    allocation_id = aws_eip.subnet_g91.id
#  }

#  subnet_mapping {
#    subnet_id     = aws_subnet.example2.id
#    allocation_id = aws_eip.example2.id
#  }
#}


resource "aws_lb_target_group" "target-group1" {
  name        = "target-group-1"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_de_terraform_ej6.id
}

resource "aws_alb_target_group_attachment" "ac1-tg-attachment-1" {
  target_group_arn = aws_lb_target_group.target-group1.arn
  target_id        = aws_instance.NGNX1.id
  port             = 80
}

resource "aws_alb_target_group_attachment" "ac1-tg-attachment-2" {
  target_group_arn = aws_lb_target_group.target-group1.arn
  target_id        = aws_instance.NGNX2.id
  port             = 80
}

resource "aws_lb" "ac1-lb" {
  name               = "ac1-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.security_group_ngnx.id]
  subnets            = [aws_subnet.g9_subnet_1.id, aws_subnet.g9_subnet_2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "ac1-listner" {
  load_balancer_arn = aws_lb.ac1-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group1.arn
  }
}


resource "aws_lb_listener_rule" "ac1-listener-rule" {
  listener_arn = aws_lb_listener.ac1-listner.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group1.arn

  }

  condition {
    path_pattern {
      values = ["/var/www/html/index.html"]
    }
  }
}


