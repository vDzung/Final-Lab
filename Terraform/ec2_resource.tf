resource "aws_instance" "VMbase" {
  ami               = data.aws_ami.ubuntu.id
  count             = 1 
  instance_type     = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ec2_secgroup.id]

  subnet_id = aws_subnet.ap-southeast-1a.id
  key_name  = "dzung_key"
  
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
   aws_vpc.my-vpc-01, aws_security_group.ec2_secgroup, aws_subnet.ap-southeast-1a,aws_subnet.ap-southeast-1b, aws_subnet.ap-southeast-1c, aws_internet_gateway.gw
    ]
  tags = {
    Name = "VMbase"
    Environment = "dev"
    Stack = "VMbase"
    Role = "frontend"
  }
}
#------------------------------------------------------------------
resource "aws_vpc" "my-vpc-01" {
  cidr_block = "172.31.0.0/16"
  enable_dns_hostnames = true
   
  tags = {
    Name = "my-vpc-01"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc-01.id

  tags = {
    Name = "Gateway"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.my-vpc-01.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "rtb-vpc01"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.ap-southeast-1a.id
  route_table_id = aws_route_table.rtb.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.ap-southeast-1b.id
  route_table_id = aws_route_table.rtb.id
}
resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.ap-southeast-1c.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_subnet" "ap-southeast-1a" {
  vpc_id            = aws_vpc.my-vpc-01.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "ap-southeast-1a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "my-subnet-1a-vpc-01"
  }
}

resource "aws_subnet" "ap-southeast-1b" {
  vpc_id            = aws_vpc.my-vpc-01.id
  cidr_block        = "172.31.16.0/20"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "my-subnet-1b-vpc-01"
  }
}

resource "aws_subnet" "ap-southeast-1c" {
  vpc_id            = aws_vpc.my-vpc-01.id
  cidr_block        = "172.31.32.0/20"
  availability_zone = "ap-southeast-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet-1c-vpc-01"
  }
}
