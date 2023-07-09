resource "aws_lb_listener" "VMbase" {
  load_balancer_arn = aws_lb.VMbase.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:ap-southeast-1:097854000435:certificate/1aed4da5-4014-4583-be02-0a27a64fe89f"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.VMbase.arn
  }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.VMbase.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
