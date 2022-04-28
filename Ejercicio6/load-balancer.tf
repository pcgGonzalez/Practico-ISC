#cambiar load balancer a load balancer application alb

resource "aws_lb" "load-balancer-ngnx" {
  name               = "instancesdengnx"
  load_balancer_type = "network"

  subnet_mapping {
    subnet_id            = aws_subnet.g9subnet1.id
    private_ipv4_address = "10.0.1.15"
  }

  subnet_mapping {
    subnet_id            = aws_subnet.g9subnet1.id
    private_ipv4_address = "10.0.1.16"
  }
}



resource "aws_lb_target_group" "test" {
  name     = "instances-ngnx"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test-terraform-vpc.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.load-balancer-ngnx.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.id
  }
}
