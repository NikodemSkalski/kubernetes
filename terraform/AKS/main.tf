resource "azurerm_kubernetes_cluster" "this" {
  location                          = var.location
  name                              = "aks-${var.name}"
  resource_group_name               = var.resource_group_name
  automatic_upgrade_channel         = "patch"
  azure_policy_enabled              = true
  dns_prefix                        = var.name
  kubernetes_version                = var.kubernetes_version
  local_account_disabled            = false
  node_os_upgrade_channel           = "NodeImage"
  oidc_issuer_enabled               = true
  private_cluster_enabled           = false
  role_based_access_control_enabled = true
  sku_tier                          = "Standard"
  tags                              = var.tags
  workload_identity_enabled         = true

  default_node_pool {
    name                    = "agentpool"
    auto_scaling_enabled    = true
    host_encryption_enabled = false
    max_count               = 1
    max_pods                = 110
    min_count               = 1
    node_labels             = var.node_labels
    orchestrator_version    = var.orchestrator_version
    os_disk_type            = var.os_disk_type
    os_sku                  = var.os_sku
    tags                    = merge(var.tags, var.agents_tags)
    vm_size                 = var.default_node_pool_vm_sku
    vnet_subnet_id          = var.network.node_subnet_id
    zones                   = ["1"]

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled ? [1] : []

    content {
      admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      azure_rbac_enabled     = var.rbac_aad_azure_rbac_enabled
      tenant_id              = var.rbac_aad_tenant_id
    }
  }


  lifecycle {
    ignore_changes = [
      kubernetes_version
    ]

  }
}