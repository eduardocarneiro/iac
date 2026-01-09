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
    # autoscaling
    {
      name  = "controller.autoscaling.enabled"
      value = "true"
    },
    {
      name  = "controller.autoscaling.minReplicas"
      value = var.nginx_min_replicas
    },
    {
      name  = "controller.autoscaling.maxReplicas"
      value = var.nginx_max_replicas
    },
    # capacity
    {
      name  = "controller.resources.requests.cpu"
      value = var.nginx_requets_cpu
    },
    {
      name  = "controller.resources.requests.memory"
      value = var.nginx_request_memonry
    },
    {
      name  = "controller.resources.limits.cpu"
      value = var.nginx_limits_cpu
    },
    {
      name  = "controller.resources.limits.memory"
      value = var.nginx_limits_memory
    },
    {
      name  = "controller.kind"
      value = "Deployment"
      // value = "Daemonset"
    }
  ]

  depends_on = [
    aws_eks_cluster.main
  ]
}

resource "kubectl_manifest" "target_binding_80" {
  yaml_body = <<YAML
apiVersion: elbv2.k8s.aws/v1beta1
kind: TargetGroupBinding
metadata:
  name: ingress-nginx
  namespace: ingress-nginx
spec:
  serviceRef:
    name: ingress-nginx-controller
    port: 80
  targetGroupARN: ${aws_lb_target_group.main.arn}
  targetType: instance
YAML
  depends_on = [
    helm_release.nginx_controller
  ]
}