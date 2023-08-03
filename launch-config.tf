resource "aws_launch_configuration" "DataredLaunchConfig" {
  image_id = "ami-0f9ce67dcf718d332"
  name_prefix = "DataredLaunchConfig-"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_sg.id]
  depends_on = [ aws_security_group.web_sg ]
  iam_instance_profile = aws_iam_instance_profile.instance_profile.name
  key_name = "aws_key"
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted = true
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 5
    encrypted = true
  }
  lifecycle {
    create_before_destroy = true
  } 
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo echo "<h1>Proyecto</h1>" > /var/www/html/index.html
              EOF
}

  
