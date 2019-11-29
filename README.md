# terraformWS
This deploys a Web Server on AWS using Terraform.

You need to install terraform first following: https://learn.hashicorp.com/terraform/getting-started/install.html

Then you need to create a terraform user from IAM in your AWS account and add the Access and Secret Keys in "terraform.tfvars"
file in the same folder as these files are.

If everything is correct, "terraform apply" command should deploy the whole environment in your AWS account.

