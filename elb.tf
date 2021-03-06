# Create a new load balancer
resource "aws_elb" "tfELB" {
  name               = "tfELB"
  subnets = ["${aws_subnet.tfPub1.id}", "${aws_subnet.tfPub2.id}"]
  security_groups = ["${aws_security_group.tfWebSrvSG.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "tfELB"
  }
}
