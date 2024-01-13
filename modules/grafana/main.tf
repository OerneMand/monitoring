resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace = var.namespace


  set {
    name  = "adminPassword"
    value = "yourPassword"
  }

    set {
    name  = "service.type"
    value = var.use_local_cluster ? "NodePort" : "LoadBalancer"
  }

  set {
    name  = "grafana.ini.paths.provisioning"
    value = "/etc/grafana/provisioning/datasources"
  }

  set {
    name  = "extraConfigmapMounts[0].name"
    value = "grafana-datasource-config"
  }

  set {
    name  = "extraConfigmapMounts[0].mountPath"
    value = "/etc/grafana/provisioning/datasources"
  }

  set {
    name  = "extraConfigmapMounts[0].configMap"
    value = "grafana-datasource-config"
  }

}

resource "kubernetes_config_map" "grafana_datasource" {
  metadata {
    name      = "grafana-datasource-config"
    namespace = var.namespace
  }

  data = {
    "datasources.yaml" = file("${path.module}/grafana-datasource.yaml")
  }
}