output "current_kubernetes_version" {
  description = "The current version running on the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.this.current_kubernetes_version
}

output "fqdn" {
  description = "The FQDN of the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.this.fqdn
}


output "identity_principal_id" {
  description = "The Principal ID associated with this Managed Service Identity"
  value       = try(azurerm_kubernetes_cluster.this.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The Tenant ID associated with this Managed Service Identity"
  value       = try(azurerm_kubernetes_cluster.this.identity[0].tenant_id, null)
}

output "kube_admin_config" {
  description = "The kube_admin_config block for the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.this.kube_admin_config
}

output "kube_admin_config_raw" {
  description = "Raw Kubernetes config for the admin account"
  value       = azurerm_kubernetes_cluster.this.kube_admin_config_raw
}

output "kube_config" {
  description = "The kube_config block for the Azure Kubernetes Managed Cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config
}

output "node_resource_group" {
  description = "The auto-generated Resource Group containing resources for the Managed Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "node_resource_group_id" {
  description = "The ID of the Resource Group containing resources for the Managed Kubernetes Cluster"
  value       = azurerm_kubernetes_cluster.this.node_resource_group_id
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL that is associated with the cluster"
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}