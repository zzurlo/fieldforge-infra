@description('Name of the Key Vault')
param vaultName string

@description('Location for the Key Vault')
param location string

@description('Azure AD tenant ID')
param tenantId string

@allowed([
  'standard'
  'premium'
])
@description('SKU name for the Key Vault')
param skuName string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: vaultName
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    enablePurgeProtection: false
    tenantId: tenantId
    accessPolicies: []
    sku: {
      name: skuName
      family: 'A'
    }
  }
}

@description('Key Vault Resource ID')
output keyVaultId string = keyVault.id

@description('Key Vault URI')
output keyVaultUri string = keyVault.properties.vaultUri

@description('Key Vault Name')
output keyVaultName string = keyVault.name
