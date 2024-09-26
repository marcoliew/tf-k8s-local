# resource "helm_release" "metrics_server" {
#   name = "metrics-server"

#   repository = "https://kubernetes-sigs.github.io/metrics-server/"
#   chart      = "metrics-server"
#   namespace  = "kube-system"
#   version    = "3.12.1"

#   values = [file("${path.module}/values/metrics-server.yaml")]

#   #depends_on = [aws_eks_node_group.spot]
# }


resource "helm_release" "kube-prometheus-stack" {
  name = "prometheus-stack"

  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  version    = "62.7.0"

  create_namespace = true

  values = [file("${path.module}/values/kube-prometheus-stack.yaml")]

  depends_on = [helm_release.nginx_ingress]
}

resource "helm_release" "nginx_ingress" {
  name = "ingress"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress"
  create_namespace = true
  version          = "4.11.2"

  values = [file("${path.module}/values/nginx-ingress.yaml")]

  #depends_on = [helm_release.aws_lbc]
}


resource "helm_release" "cadvisor" {
  name = "cadvisor"

  repository       = "https://ckotzbauer.github.io/helm-charts"
  chart            = "cadvisor"
  namespace        = "monitoring"
  #create_namespace = true
  version          = "2.3.3"

  values = [file("${path.module}/values/cadvisor.yaml")]

    #=-][[depends_on = [helm_release.aws_lbc]
}

resource "helm_release" "loki" {
  name = "loki"

  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  namespace        = "monitoring"
  #create_namespace = true
  version          = "6.12.0"

  values = [file("${path.module}/values/loki.yaml")]

    depends_on = [helm_release.kube-prometheus-stack]
}

# resource "helm_release" "istio_cni" {
#   name = "cni"

#   repository       = "https://istio-release.storage.googleapis.com/charts"
#   chart            = "cni"
#   namespace        = "kube-system"
#   #create_namespace = true
#   version          = "1.23.2"

#   values = [file("${path.module}/values/cni.yaml")]

#     #=-][[depends_on = [helm_release.aws_lbc]
# }


# resource "helm_release" "blackbox-exporter" {
#   name = "blackbox-exporter"

#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus-blackbox-exporter"
#   namespace  = "monitoring"
#   version    = "9.0.0"

#   #create_namespace = true

#   values = [file("${path.module}/values/blackbox-exporter.yaml")]

#   depends_on = [helm_release.kube-prometheus-stack]
# }