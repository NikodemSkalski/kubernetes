output "fqdn" {
  value = module.aks.fqdn
}

output "kube_config_raw" {
  description = "Raw Kubernetes config for the cluster user"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for the cluster"
  value = module.aks.oidc_issuer_url
}
