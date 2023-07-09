resource "aws_route53_record" "VMbase" {
  zone_id = "Z03030003A4YBK0R0418D" 
  name    = "jenkins.dzung.tk"
  type    = "A"
  alias {
    name                    = aws_lb.VMbase.dns_name
    zone_id                 = aws_lb.VMbase.zone_id
    evaluate_target_health  = true
  }
}
