output "aws_ami" {
  value = data.aws_ami.ubuntu.id
}
output "aws_vpc" {
  value = aws_vpc.my-vpc-01.id
}
output "aws_internet_gateway" {
  value = aws_internet_gateway.gw.id
}
output "aws_route_table" {
  value = aws_route_table.rtb.id
}
output "aws_subnet-01-1a" {
  value = aws_subnet.ap-southeast-1a.id
}
output "aws_subnet-02-1b" {
  value = aws_subnet.ap-southeast-1b
}
output "aws_subnet-03-1c" {
  value = aws_subnet.ap-southeast-1c.id
}
output "aws_security_group" {
  value = aws_security_group.ec2_secgroup.id
}
output "ec2_private_ip" {
  value =  aws_instance.VMbase.*.private_ip
}
output "ec2_public_ip" {
  value =  aws_instance.VMbase.*.public_ip
}