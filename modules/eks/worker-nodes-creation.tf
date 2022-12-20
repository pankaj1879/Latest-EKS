resource "aws_eks_node_group" "non-prod" {
  
  cluster_name = aws_eks_cluster.eks.name
  node_group_name = var.env
  node_role_arn = aws_iam_role.eks_cluster.arn

  subnet_ids = [
    var.private_subnet_1,
    var.private_subnet_2
  ]

  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 2
  }

  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  disk_size = 20
  force_update_version = false
  instance_types = ["t2.medium"]

  labels = {
    role = "worker-nodes"
  }
  version = var.eks_version

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}
