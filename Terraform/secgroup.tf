//secgroup ALB
resource "aws_security_group" "alb_secgroup" {
  name        = "alb_secgroup"
  description = "Allow access HTTP and HTTPS"
  vpc_id      = aws_vpc.my-vpc-01.id
  
ingress {
    description      = "Allow all IP access HTTP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

ingress {
    description      = "Allow all IP access HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  ingress {
    description      = "Allow all IP access HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb_secgroup"
  }
}

//secgroup ec2
resource "aws_security_group" "ec2_secgroup" {
  name        = "ec2_secgroup"
  description = "Allow SSH and ALB secgroup"
  vpc_id      = aws_vpc.my-vpc-01.id
  
    ingress {
    description      = "Allow SSH from only my IP"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["42.114.237.198/32"]
    #ipv6_cidr_blocks = ["::/0"]
  }

    ingress {
    description      = "Allow traffic only from ALB"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.alb_secgroup.id}"]

  }

  ingress {
    description      = "Allow traffic only from ALB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = ["${aws_security_group.alb_secgroup.id}"]

  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ec2_secgroup"
  }
}