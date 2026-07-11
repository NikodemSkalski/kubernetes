@description('Optional. The name of the resource')
@maxLength(24)
param storageName string = ''

@description('Optional. The location of the resource')
param location string = resourceGroup().location

@description('Optional. The environment of the resource')
param environment string = 'dev'

@description('Optional. The kind of the storage account')
@allowed([
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param kind string = 'StorageV2'

@description('Optional. The SKU of the storage account')
param blobContainerName string = ''

@description('Optional. The SKU of the storage account')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
])
param skuName string = 'Standard_LRS'

@description('Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set and networkAcls are not set.')
@allowed([
  'Enabled'
  'Disabled'
  'SecuredByPerimeter'
])
param publicNetworkAccess string?

@description('Optional. Blob service and containers to deploy.')
param blobServices object = kind != 'FileStorage'
  ? {
      containerDeleteRetentionPolicyEnabled: true
      containerDeleteRetentionPolicyDays: 7
      deleteRetentionPolicyEnabled: true
      deleteRetentionPolicyDays: 6
    }
  : {}


@description('Optional. Indicates whether public access is enabled for all blobs or containers in the storage account. For security reasons, it is recommended to set it to false.')
param allowBlobPublicAccess bool = false


@description('Optional. Enables local users feature, if set to true.')
param isLocalUserEnabled bool = false

var storageAccountName = empty(storageName) ? 'st${take('${environment}${uniqueString(resourceGroup().id, environment)}', 22)}' : storageName
var blobName = empty(blobContainerName) ? 'container${uniqueString(resourceGroup().id, environment)}' : blobContainerName


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: kind
  sku: {
    name: skuName
  }
  properties: {
    allowBlobPublicAccess: allowBlobPublicAccess
    isLocalUserEnabled: isLocalUserEnabled
    publicNetworkAccess: publicNetworkAccess
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = if (kind != 'FileStorage') {
  name: blobName
  parent: storageAccount
  properties: blobServices
}
