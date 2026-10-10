variable "location" {
  type        = string
  description = "The Azure region to deploy the AKS cluster into."
  default     = "eastus"
}

variable "name" {
  type        = string
  description = "The name used to build the AKS cluster's resource names."
  default     = "some-aks"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group the AKS cluster is deployed into."
}

variable "role_based_access_control_enabled" {
  type        = bool
  description = "Whether to enable role-based access control (RBAC) for the AKS cluster."
  default     = false
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  description = "The list of Azure Active Directory (AAD) group object IDs that will be granted admin access to the AKS cluster when RBAC is enabled."
  default     = []
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  description = "Whether to enable Azure RBAC for the AKS cluster when RBAC is enabled."
  default     = false 
}

variable "rbac_aad_tenant_id" {
  type        = string 
  description = "The Azure Active Directory (AAD) tenant ID associated with the AKS cluster when RBAC is enabled."
  default     = ""
}
