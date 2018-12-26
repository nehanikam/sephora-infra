resource "aws_security_group" "instance-sg" {
  vpc_id = "${aws_vpc.main.id}"
  name = "instance-sg"
  description = "security group for instances"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
      from_port = 3000
      to_port = 3000
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

tags {
    Name = "instance-sg"
  }
}



resource "aws_security_group" "allow-postgreSQL" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-postgreSQL"
  description = "allow-postgreSQL"
  ingress {
      from_port = 5432
      to_port = 5432
      protocol = "tcp"
      security_groups = ["${aws_security_group.instance-sg.id}"]              # allowing access from our example instance
  }
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      self = true
  }
  tags {
    Name = "allow-postgreSQL"
  }
}

