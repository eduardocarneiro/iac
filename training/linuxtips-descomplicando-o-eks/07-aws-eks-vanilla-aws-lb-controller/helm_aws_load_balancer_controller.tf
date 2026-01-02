resource "helm_release" "alb_ingress_controller" {
  name             = "aws-load-balancer-controller"
  repository       = "https://aws.github.io/eks-charts"
  chart            = "aws-load-balancer-controller"
  namespace        = "aws-lb-controller"
  create_namespace = true

  set = [{
    name  = "clusterName"
    value = var.aws_lb_controller_name
    },
    {
      name  = "serviceAccount.create"
      value = true
    },
    {
      name  = "serviceAccount.name"
      value = "aws-load-balancer-controller"
    },
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.aws_lb_controller.arn
    },
    {
      name  = "region"
      value = var.region
    },
    {
      name  = "vpcId"
      value = data.aws_ssm_parameter.vpc.value
    },
  ]

  depends_on = [
    aws_eks_cluster.main
    #helm_release.karpenter,
    #aws_eks_fargate_profile.karpenter,
    #aws_eks_fargate_profile.kube_system,
  ]
}