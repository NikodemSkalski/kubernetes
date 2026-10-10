using '../deployment.bicep'

param location = 'eastus'
param environment = 'development'
param kind = 'StorageV2'
param skuName = 'Standard_LRS'
param blobContainerNameParam = 'aks-terraformstate'
param allowBlobPublicAccess = false
