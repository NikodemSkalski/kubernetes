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
