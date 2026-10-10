module "aks" {
  source = "../AKS"

  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  role_based_access_control_enabled = var.role_based_access_control_enabled
  rbac_aad_admin_group_object_ids = var.rbac_aad_admin_group_object_ids
  rbac_aad_tenant_id = var.rbac_aad_tenant_id
}
