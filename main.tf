data "aws_vpc" "main" {
  tags = {
    Name = "myVPC"
  }
}

resource "aws_instance" "myInstance" {
  ami           = "ami-0c24ee2a1e3b9df45"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  key_name      = "vivek-key"  # Change to your key pair name

  tags = {
    Name = "MyWebServer"
  }

  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  user_data = file("${path.module}/userdata.sh")
  user_data_replace_on_change = true
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}