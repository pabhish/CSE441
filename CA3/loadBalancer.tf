# Create a load balancer for the EC2 instance
resource "aws_lb" "lb" {
  name = "lb"
  subnets = [aws_subnet.subnet.id]
  security_groups = [aws_security_group.security_group.id]

  tags = {
    Name = "lb"
  }

  # Configure health check and listener
  enable_deletion_protection = false

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    timeout = 10

    path = "/"
    protocol = "HTTP"
    port = 80
  }

  listener {
    port = 80
