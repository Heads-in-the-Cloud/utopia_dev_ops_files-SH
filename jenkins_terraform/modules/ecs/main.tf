

// ECS Resources

// load balancing
resource "aws_lb" "utopia_nwb" {
  name = "nwb-utopia-SH"
  internal = false
  load_balancer_type = "network"
  subnets = var.service_subnets
}

// route 53
resource "aws_route53_record" "utopia_record" {
  zone_id = var.r53_zone_id
  name = "sh-ecs.hitwc.link"
  type = "CNAME"
  ttl = "20"
  records = [aws_lb.utopia_nwb.dns_name]
}


// Security

resource "aws_security_group" "ecs_api_security" {
  name = "ecs-allow-apis-SH"
  description = "Open SSH and all API ports"
  vpc_id = var.vpc_id

  # SSH port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Data API ports
  ingress {
    from_port   = 5010
    to_port     = 5010
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5020
    to_port     = 5020
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5030
    to_port     = 5030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5040
    to_port     = 5040
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5050
    to_port     = 5050
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Auth API port
  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outgoing coverage
  egress {
    from_port     = 0
    to_port       = 0
    protocol      = "-1"
    cidr_blocks   = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-apis-SH"
  }
}
