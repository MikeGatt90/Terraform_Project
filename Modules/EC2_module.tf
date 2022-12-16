#  Create ec2 instances
resource "aws_instance" "web1" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "team-gold"
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start 
        systemctl enable
        echo "<html><body>LUIT Gold Team!</h1></body></html>" > /var/www/html/index.html
        EOF

  tags = {
    Name = "web1_instance"
  }
}
resource "aws_instance" "web2" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "team-gold"
  availability_zone           = "us-east-1b"
  vpc_security_group_ids      = [aws_security_group.public_sg.id]
  subnet_id                   = aws_subnet.public_2.id
  associate_public_ip_address = true
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start 
        systemctl enable
        echo "<html><body>We are almost at the finish line!</h1></body></html>" > /var/www/html/index.html
        EOF

  tags = {
    Name = "web2_instance"
  }
}

resource "aws_instance" "Bastion" {
  ami                         = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "team-gold"
  availability_zone           = "us-east-1a"
  vpc_security_group_ids      = [Bastion_security_group.Bastion_sg.id]
  subnet_id                   = aws_subnet.public_1.id
  associate_public_ip_address = true
  user_data                   = <<-EOF
        #!/bin/bash
        yum update -y
        yum install httpd -y
        systemctl start 
        systemctl enable
        echo "<html><body>Christmas is around the corner</h1></body></html>" > /var/www/html/index.html
        EOF

  tags = {
    Name = "Bastion_instance"
  }
}
# Database subnet group
resource "aws_db_subnet_group" "default" {
  name       = "db_subnetgroup"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
}