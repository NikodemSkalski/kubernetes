
@description('Optional. Name of your Azure Container Registry.')
@maxLength(50)
param name string = ''

@description('Optional. Enable admin user that have push / pull permission to the registry.')
param acrAdminUserEnabled bool = false

@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('Optional. Tier of your Azure container registry.')
@allowed([
  'Basic'
  'Premium'
  'Standard'
])
param acrSku string = 'Premium'

@allowed([
  'disabled'
  'enabled'
])
@description('Optional. The value that indicates whether the retention policy is enabled or not.')
param retentionPolicyStatus string = 'enabled'

@description('Optional. The number of days to retain an untagged manifest after which it gets purged.')
param retentionPolicyDays int = 15

@description('Optional. Whether or not public network access is allowed for this resource. For security reasons it should be disabled. If not specified, it will be disabled by default if private endpoints are set and networkRuleSetIpRules are not set.  Note, requires the \'acrSku\' to be \'Premium\'.')
@allowed([
  'Enabled'
  'Disabled'
])
param publicNetworkAccess string = 'Enabled'


@allowed([
  'AzureServices'
  'None'
])
@description('Optional. Whether to allow trusted Azure services to access a network restricted registry.')
param networkRuleBypassOptions string = 'AzureServices'

@allowed([
  'disabled'
  'enabled'
])
@description('Optional. The value that indicates whether the export policy is enabled or not.')
param exportPolicyStatus string = 'disabled'

@allowed([
  'disabled'
  'enabled'
])
@description('Optional. The value that indicates whether the quarantine policy is enabled or not. Note, requires the \'acrSku\' to be \'Premium\'.')
param quarantinePolicyStatus string = 'disabled'

@allowed([
  'disabled'
  'enabled'
])
@description('Optional. The value that indicates whether the trust policy is enabled or not. Note, requires the \'acrSku\' to be \'Premium\'.')
param trustPolicyStatus string = 'disabled'

@description('Optional. Enable a single data endpoint per region for serving data. Not relevant in case of disabled public access. Note, requires the \'acrSku\' to be \'Premium\'.')
param dataEndpointEnabled bool = false

@description('Optional. Enables registry-wide pull from unauthenticated clients. It\'s in preview and available in the Standard and Premium service tiers.')
param anonymousPullEnabled bool = false

var registryName = empty(name) ? 'acr${take('${uniqueString(resourceGroup().id)}', 8)}' : name

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: registryName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    anonymousPullEnabled: anonymousPullEnabled
    adminUserEnabled: acrAdminUserEnabled
    dataEndpointEnabled: dataEndpointEnabled
    encryption: {
      status: 'disabled'
    }
    networkRuleBypassOptions: networkRuleBypassOptions
    policies: {
      exportPolicy: acrSku == 'Premium'
        ? {
            status: exportPolicyStatus
          }
        : null
      quarantinePolicy: acrSku == 'Premium'
        ? {
            status: quarantinePolicyStatus
          }
        : null
      retentionPolicy: acrSku == 'Premium'
        ? {
            days: retentionPolicyDays
            status: retentionPolicyStatus
          }
        : null
      trustPolicy: acrSku == 'Premium'
        ? {
            type: 'Notary'
            status: trustPolicyStatus
          }
        : null
    }
    publicNetworkAccess: publicNetworkAccess
    zoneRedundancy: 'Disabled'
  }
}




output registryName string = registry.name
output registryLoginServer string = registry.properties.loginServer

