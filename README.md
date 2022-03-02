# nginx-webserver-terraform-demo
Create an EC2 instance with terraform and install nginx and hence serve an index page.


## Create and apply the terraform file to create the instance and install/start apache
1. Create a terraform file to create the aws instance and bootstrap the user_data
``` 
user_data = <<-EOF
          #! /bin/bash
          sudo yum install epel-release
          sudo yum update -y
          sudo amazon-linux-extras enable nginx1.12
          sudo yum -y install nginx
          sudo systemctl start nginx
          sudo systemctl enable nginx
          chmod 2775 /usr/share/nginx/html
          find /usr/share/nginx/html -type d -exec chmod 2775 {} \;
          find /usr/share/nginx/html -type f -exec chmod 0664 {} \;
          echo "<h3> Nginx server</h3>" > /usr/share/nginx/html/index.html

  EOF
  ```
2. Store the provider configuration details in provider.tf.
3. Define all the variables in a variables.tf.
4. Assign the secret variables like AWS access key and secret keys in a separate terraform.tfvars
```terraform
terraform init
terraform plan
terraform apply
```
## Validate the webserver
1. ssh into the public ip of the aws instance with the pem file
2. verify that it outputs the html text
```
chmod 400 terra-udemy.pem
ssh -i "terra-udemy.pem" ec2-user@ec2-3-239-201-90.compute-1.amazonaws.com
```
3. Also, browse public ip of the ec2 instance and check if the html text is rendered
