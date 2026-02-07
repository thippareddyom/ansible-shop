resource "aws_eks_cluster" "main" {
  name = var.env
  version = var.eks_version

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  role_arn = aws_iam_role.cluster-role.arn

  vpc_config {
    subnet_ids = var.subnets
  }

}

resource "aws_eks_node_group" "name" {
  for_each = var.node_groups
  cluster_name = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn = aws_iam_role.node-role.arn
  capacity_type = "SPOT"
  scaling_config {
    desired_size = each.value.min_nodes
    max_size = each.value.max_nodes
    min_size = each.value.min_nodes
  }
  subnet_ids = var.subnets
}


# resource "aws_iam_role" "import_role" {
#   name = "dev-eks-cluster-role"
#   assume_role_policy = jsonencode(
#     {
#       "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Principal": {
#                 "Service": "eks.amazonaws.com"
#             },
#             "Action": [
#                 "sts:AssumeRole",
#                 "sts:TagSession"
#             ]
#         }
#     ]
#     }
#   )
# }