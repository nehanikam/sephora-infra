resource "aws_instance" "ubuntu" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.instance-sg.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"


  tags {
    Name = "sephora-app-instance"
  }

  provisioner "file" {
    source = "install_psql.sh"
    destination = "/tmp/install_psql.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_psql.sh",
      "sudo /tmp/install_psql.sh"
    ]
  }
  connection {
    user = "${var.INSTANCE_USERNAME}"
    private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }
}
