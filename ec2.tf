# launching an EC2 instance for Nginx web server

resource "aws_instance" "nginx_server" {
  ami                         = "ami-0157af9aea2eef346"
  instance_type               = "t3.large"
  subnet_id                   = aws_subnet.public-subnet.id
  vpc_security_group_ids      = [aws_security_group.nginx-sg.id]
  associate_public_ip_address = true

  # User data script to install and start Nginx
  user_data = <<-EOF
                #!/bin/bash
                sudo yum update -y
                sudo yum install nginx -y
                sudo systemctl start nginx
                sudo systemctl enable nginx
                EOF

  tags = {
    Name = "nginx_server"
  }

}
