# provider "aws" {
#   region = local.region
# }

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
}

provider "helm" {
  # Local Kubernetes cluster from Docker Desktop
  kubernetes {
    # Load the kubeconfig from your home directory
    config_path = "~/.kube/config"
    config_context = "docker-desktop"
  }
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    # Kubernetes provider
    kubernetes = {
      source  = "hashicorp/kubernetes"
    }

  }

}
