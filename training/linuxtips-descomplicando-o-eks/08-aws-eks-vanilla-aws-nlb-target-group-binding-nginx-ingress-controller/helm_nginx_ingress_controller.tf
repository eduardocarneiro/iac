resource "helm_release" "nginx_controller" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  chart      = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.11.3"

  create_namespace = true

  set = [
    {
      name  = "controller.service.internal.enabled"
      value = "true"
    },
    {
      name  = "controller.publishService.enable"
      value = "true"
    },
    {
      name  = "controller.service.type"
      value = "NodePort"
    },
  ]

  depends_on = [
    aws_eks_cluster.main
  ]
}



