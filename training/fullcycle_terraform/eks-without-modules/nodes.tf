resource "aws_iam_role" "nodes" {
    name = "${var.prefix}-${var.cluster_name}-node-role"
    assume_role_policy =  <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]

}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSWorkerNodePolicy" {
    role = aws_iam_role.nodes.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKS_CNI_Policy" {
    role = aws_iam_role.nodes.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEC2ContainerRegistryReadOnly" {
    role = aws_iam_role.nodes.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_node_group" "nodes-a" {
    cluster_name = aws_eks_cluster.cluster.name
    node_group_name = "nodes-a"
    node_role_arn = aws_iam_role.nodes.arn
    subnet_ids = aws_subnet.subnets[*].id
    instance_types = ["t3.micro"]
    scaling_config {
      desired_size = var.desired_size
      max_size = var.max_size
      min_size = var.min_size
    }
    depends_on = [ 
        aws_iam_role_policy_attachment.cluster-AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.cluster-AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly
     ]
    
}

