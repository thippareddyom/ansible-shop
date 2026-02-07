# resource "aws_instance" "ec2" {
#   ami = var.ami
#   instance_type = var.instance_type
#   vpc_security_group_ids = ["sg-039813d39262650f5"]

#   tags = {
#     "Name"= "frontend"
#   }
# }

# data "aws_route53_zone" "get_zone_id" {
#   name = "kvsr.online"
# }

# resource "aws_route53_record" "record" {
#   name = "frontend-dev.kvsr.online"
#   zone_id = data.aws_route53_zone.get_zone_id.id
#   records = [aws_instance.ec2.public_ip]
#   type = "A"
#   ttl = "10"
# }