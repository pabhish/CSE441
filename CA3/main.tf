provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "aditya-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "aditya-vpc"
  }
}

resource "aws_subnet" "aditya-subnet" {
  vpc_id     = aws_vpc.aditya-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "aditya-subnet"
  }
}

resource "aws_internet_gateway" "aditya-igw" {
  vpc_id = aws_vpc.aditya-vpc.id

  tags = {
    Name = "aditya-igw"
  }
}

resource "aws_route_table" "aditya-rt" {
  vpc_id = aws_vpc.aditya-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aditya-igw.id
  }

  tags = {
    Name = "aditya-rt"
  }
}

resource "aws_route_table_association" "aditya-rta" {
  subnet_id      = aws_subnet.aditya-subnet.id
  route_table_id = aws_route_table.aditya-rt.id
}

resource "aws_instance" "aditya-instance" {
  ami           = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.aditya-subnet.id

  tags = {
    Name = "aditya-instance"
  }

  vpc_security_group_ids = [aws_security_group.aditya-sg.id]
}

resource "aws_security_group" "aditya-sg" {
  name_prefix = "aditya-sg"
  vpc_id      = aws_vpc.aditya-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "aditya-lb" {
  name               = "aditya-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.aditya-subnet.id]

  tags = {
    Name = "aditya-lb"
  }
}

resource "aws_lb_target_group" "aditya-tg" {
  name     = "aditya-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.aditya-vpc.id

  health_check {
    protocol = "HTTP"
    port     = "traffic-port"
    path     = "/"
  }
}

resource "aws_lb_target_group_attachment" "aditya-tg-attachment" {
  target_group_arn = aws_lb_target_group.aditya-tg.arn
  target_id        = aws_instance.aditya-instance.id
  port             = 80
}
