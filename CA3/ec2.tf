# Create an EC2 instance in the public subnet
resource "aws_instance" "instance" {
  ami = "ami-0c94855ba95c71c99"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  subnet_id = aws_subnet.subnet.id

  tags = {
    Name = "instance"
  }
}
