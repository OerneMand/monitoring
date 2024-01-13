variable "use_local_cluster" {
  description = "Set to true to use a local Kubernetes cluster"
  type        = bool
  default     = true
}

variable "local_config_path" {
  description = "Path to the kubeconfig file for local cluster"
  type        = string
  default     = "~/.kube/config"
}
