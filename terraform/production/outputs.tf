output "fqdn" {
  value = module.aks.fqdn
}

output "kube_config_raw" {
  value     = module.aks.kube_admin_config_raw
  sensitive = true
}

output "oidc_issuer_url" {
  value = module.aks.oidc_issuer_url
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value = module.aks.cluster_name
}
