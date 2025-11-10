# creating a security group for the nginx web server

resource "aws_security_group" "nginx-sg" {
  name        = "nginx-sg"
  description = "Security group for Nginx web server"
  vpc_id      = aws_vpc.my-vpc.id

  #inbound rule to allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #outbound rule to allow all traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}