resource "aws_lb_target_group" "VMbase" {
  name        = "dev-demo-VMbase"
  port        = 8080
  protocol    = "HTTP"
  vpc_id = aws_vpc.my-vpc-01.id
}

resource "aws_lb_target_group_attachment" "VMbase" {
  count = length(aws_instance.VMbase)
  target_group_arn = aws_lb_target_group.VMbase.arn
  target_id = aws_instance.VMbase[count.index].id
  port             = 8080
  depends_on       = [aws_lb_target_group.VMbase, aws_instance.VMbase]
}
