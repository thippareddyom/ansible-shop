# module "ec2" {
#   source = "./ec2"
#   ami = ""
#   instance_type = ""
# }

# resource "null_resource" "name" {
  
# }

# resource "aws_instance" "ec2" {
#   ami= var.ami_id
#   instance_type = var.instance_type
#   vpc_security_group_ids = ["sg-039813d39262650f5"]
# }

# variable "ami_id" {
#   validation {
#     condition = length(var.ami_id) > 4 && substr(var.ami_id,0,4)=="ami-"
#     error_message = "The ami id must start with ami"
#   }
# }
# variable "instance_type" {
#   default = "t3.micro"
# }
# variable "instance" {
#   default = {
#     catalogue =     null
#     mongodb   =     null
#     frontend  =     null
    
#   }
# }

# variable "ami_id" {
#   default = "ami-0220d79f3f480ecf5"
# validation {
#   condition =length (var.ami_id) > 4 && substr(var.ami_id,0,4)=="ami-"
#   error_message = "ami id enter corrected one"
# }  
# }

# variable "instance_type" {
#   default = "t3.micro"
# }

# variable "env" {
#   default = "dev"
# }

# resource "aws_instance" "instance" {
#   # count = length(var.instance)
#   for_each = var.instance
#   ami= var.ami_id
#   instance_type = var.instance_type
#   tags = {
#     "Name"= each.key
#   }
# }

# data "aws_route53_zone" "get_zone_id" {
#   name = "kvsr.online"
# }

# resource "aws_route53_record" "record" {
#   for_each = var.instance
#   zone_id = data.aws_route53_zone.get_zone_id.id
#   name = "${each.key}-${var.env}.kvsr.online"
#   ttl = 10
#   type = "A"
#   records = [aws_instance.instance[each.key].private_ip]
# }

# module "null-resources" {
#   source = "./null-res-module"
# }

# module "resource-count" {
#   source = "./resource-count"
#   input = module.null-resources.null-res
# }

# output "name" {
#   value = module.resource-count.resorce-count
# }

module "ec2" {
  for_each = var.db_instances
  source = "./modules/ec2"
  ami = each.value.ami
  instance_type = each.value.instance_type
  zone_id = var.zone_id
  vpc_security_group_ids = var.vpc_security_group_ids
  name = each.key
  env = var.env
}

# module "eks" {
#   source = "terraform-aws-modules/eks/aws"
#   version = "21.15.0"
#   name= "main"
#   kubernetes_version = 1.32
#   enable_cluster_creator_admin_permissions = true
#   endpoint_public_access = true
#   compute_config = {
#     enabled      = true
#     node_pools   = ["general-purpose"]
#   }
#   subnet_ids = ["subnet-039da80d8264e0a4d","subnet-05fe51d21afe293ad"]

#   tags = {
#     Name= "dev"
#   }
# }

module "eks" {
  for_each = var.eks

  source = "./modules/eks"
  subnets = each.value.subnets
  env = var.env
  eks_version = each.value.eks_version
  node_groups= each.value["node_groups"]
}
