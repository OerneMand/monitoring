variable "namespace" {
  type        = string
  description = "Kubernetes namespace"
}
variable "use_local_cluster" {
  description = "Set to true to use a local Kubernetes cluster"
  type        = bool
  default     = true 
}