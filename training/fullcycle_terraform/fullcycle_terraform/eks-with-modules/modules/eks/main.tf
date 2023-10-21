resource "aws_security_group" "eks-sg" {
    vpc_id = var.vpc_id
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }
    tags = {
        Name = "${var.prefix}-sg"
    }

}

resource "aws_iam_role" "cluster" {
    name = "${var.prefix}-${var.cluster_name}-eks-role"
    assume_role_policy =  <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]

}
POLICY
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSVPCResourceController" {
    role = aws_iam_role.cluster.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

resource "aws_iam_role_policy_attachment" "cluster-AmazonEKSClusterPolicy" {
    role = aws_iam_role.cluster.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_cloudwatch_log_group" "eks-log" {
    name = "/aws/eks/${var.prefix}-${var.cluster_name}/cluster"
    retention_in_days = "${var.retention_days}"
}

resource "aws_eks_cluster" "cluster" {
    name = "${var.prefix}-${var.cluster_name}"
    role_arn = aws_iam_role.cluster.arn
    enabled_cluster_log_types = [ "api", "audit" ]

    vpc_config {
        subnet_ids = var.subnet_ids
        security_group_ids = [ aws_security_group.eks-sg.id ]
    }

    depends_on = [ 
        aws_cloudwatch_log_group.eks-log,
        aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.cluster-AmazonEKSVPCResourceController
     ]
}

### Nodes 

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
    subnet_ids = var.subnet_ids
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

