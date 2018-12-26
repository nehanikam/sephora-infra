output "instance" {
  value = "${aws_instance.ubuntu.public_ip}"
}
output "rds" {
  value = "${aws_db_instance.postgres.endpoint}"
}
