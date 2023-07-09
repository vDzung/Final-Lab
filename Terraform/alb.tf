resource "aws_lb" "VMbase" {
  name               = "alb-VMbase"
  internal = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_secgroup.id]
  subnet_mapping {
  subnet_id     = aws_subnet.ap-southeast-1a.id
  }
  subnet_mapping {
  subnet_id     = aws_subnet.ap-southeast-1b.id
  }
  subnet_mapping {
  subnet_id     = aws_subnet.ap-southeast-1c.id
  }
    depends_on = [
   aws_subnet.ap-southeast-1a,aws_subnet.ap-southeast-1b, aws_subnet.ap-southeast-1c
    ]
  enable_deletion_protection = false
   tags = {
    Name = "ALB-VMbase"
    Environment = "dev"
  }
}