resource "aws_autoscaling_group" "tfWebSrvAs" {
  name_prefix               = "tfWebSrvAsGroup"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 1200
  health_check_type         = "ELB"
  load_balancers            = ["${aws_elb.tfELB.name}"]
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.tfWebSrvLC.name}"
  vpc_zone_identifier       = ["${aws_subnet.tfPub1.id}", "${aws_subnet.tfPub2.id}"]
}

resource "aws_autoscaling_policy" "tfScPol" {
  name                   = "tfScalingPolicy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 500
  autoscaling_group_name = "${aws_autoscaling_group.tfWebSrvAs.name}"
}
