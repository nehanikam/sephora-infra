resource "aws_db_subnet_group" "psql-subnet" {
    name = "psql-subnet"
    description = "RDS subnet group"
    subnet_ids = ["${aws_subnet.main-private-1.id}","${aws_subnet.main-private-2.id}"]
}



resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "9.5.2"
  instance_class       = "db.t2.micro"
  identifier           = "sephoradb"
  name                 = "sephoradb"
  username             = "root"   # username
  password             = "${var.RDS_PASSWORD}" # password
  db_subnet_group_name = "${aws_db_subnet_group.psql-subnet.name}"
  multi_az             = "false"     # set to true to have high availability
  vpc_security_group_ids = ["${aws_security_group.allow-postgreSQL.id}"]
  storage_type         = "gp2"
  backup_retention_period = 0 # we dont need backup for trails
  availability_zone = "${aws_subnet.main-private-1.availability_zone}"   # prefered AZ
  skip_final_snapshot = true   # skip final snapshot when doing terraform destroy
  tags {
      Name = "sephora-db-instance"
  }
}
