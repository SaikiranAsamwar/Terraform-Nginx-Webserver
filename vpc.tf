#Fully functional VPC for AWS Terraform Nginx Webserver Project


# Create a VPC
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

# Create Public subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name = "public-subnet"
  }
}

#Create Private subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name = "private-subnet"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

# Create Public Route Table

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "public-rt"
  }

}

# Associate Public Subnet with Public Route Table

resource "aws_route_table_association" "public-subnet" {
  route_table_id = aws_route_table.public-rt.id
  subnet_id      = aws_subnet.public-subnet.id
}


