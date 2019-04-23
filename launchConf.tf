#This is done because AMI's can change over time.
#Instead of feeding an AMI ID directly, data module
# can be used to filter the Linux AMI's owned by
# Amazon, then choose the most recent Amazon Linux AMI

data "aws_ami" "amzLx" {
  filter {
    name   = "image-id"
    values = ["ami-0de53d8956e8dcf80"]
  }

  owners = ["137112412989"]
}


#Create the launch config by feeding the AMI ID we pulled
# with the function above

resource "aws_launch_configuration" "tfWebSrvLC" {
  name = "tfWebSrvLC"
  image_id = "${data.aws_ami.amzLx.id}"
  instance_type = "t2.micro"
  user_data = "${file("webSrvScript")}"
  security_groups = ["${aws_security_group.tfWebSrvSG.id}"]
  key_name = "btcProj"
  iam_instance_profile = "${aws_iam_instance_profile.tfS3InsPr.name}"
}
