#Create the role to be attached to the instances
resource "aws_iam_role" "tfS3Role" {
  name = "tfS3Role"

  assume_role_policy = <<EOF
	{
	  "Version": "2012-10-17",
	  "Statement": [
    {
		      "Action": "sts:AssumeRole",
		      "Principal": {
		      "Service": "ec2.amazonaws.com"
      		       },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#Add role policy to the created role
resource "aws_iam_role_policy" "tfS3Policy" {
  name = "tfS3Policy"
  role = "${aws_iam_role.tfS3Role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": 
    [
      {
        "Action": ["s3:*"],
        "Effect": "Allow",
        "Resource": 
        [
	  "arn:aws:s3:::gorkbucket",
	  "arn:aws:s3:::gorkbucket/*"
	]
      }
    ]
  }
EOF
}

#Assign the created role to a instance profile
resource "aws_iam_instance_profile" "tfS3InsPr" {
  name = "tfS3InsPr"
  role = "${aws_iam_role.tfS3Role.name}"
}


