provider "kubernetes" {
    config_path = var.use_local_cluster ? var.local_config_path : "/path/to/cloud/env"
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"  
    }
}

resource "kubernetes_namespace" "monitoring" {
    metadata {
        name = "monitoring"
    }
}

module "prometheus" {
    source    = "./modules/prometheus"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
}

module "grafana" {
    source    = "./modules/grafana"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
    use_local_cluster = var.use_local_cluster
}