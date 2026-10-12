output "fqdn" {
  value = module.aks.fqdn
}

output "kube_config_raw" {
  description = "Raw Kubernetes config for the cluster user"
  value       = module.aks.kube_config_raw
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for the cluster"
  value = module.aks.oidc_issuer_url
}

output "cluster_name" {
  description = "Name of the AKS cluster"
  value = module.aks.cluster_name
}