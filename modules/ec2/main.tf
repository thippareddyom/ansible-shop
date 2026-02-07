resource "aws_instance" "instance" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  instance_market_options {
    market_type = "spot"
  }
  tags = {
    Name = var.name 
  }
}

resource "aws_route53_record" "record" {
  zone_id = var.zone_id  
  name = "${var.name}-${var.env}"
  ttl = 10
  type = "A"
  records = [aws_instance.instance.public_ip]
}

resource "null_resource" "ec2" {
depends_on = [ aws_route53_record.record ]

provisioner "remote-exec" {
    connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.instance.public_ip
  }
  inline = [ "sudo pip3.11 install ansible",
  "ansible-pull -i localhost, -U https://github.com/thippareddyom/ansible-shop.git roboshop.yml -e component_name=${var.name} -e env=${var.env}" ]
}

}