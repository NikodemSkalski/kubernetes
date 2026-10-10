using '../deployment.bicep'

param location = 'eastus'
param environment = 'production'
param kind = 'StorageV2'
param skuName = 'Standard_LRS'
param blobContainerNameParam = 'aks-terraformstate'
param allowBlobPublicAccess = false
