using '../deployment.bicep'

param location = 'eastus'
param environment = 'dev'
param kind = 'StorageV2'
param skuName = 'Standard_LRS'
param blobContainerName = 'terraformstate'
param allowBlobPublicAccess = false
