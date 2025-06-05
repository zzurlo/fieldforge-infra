targetScope = 'subscription'

@description('Name of the resource group')
param name string

@description('Azure region for the resource group')
param location string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: name
  location: location
  tags: {
    deployedBy: 'Bicep'
  }
}

output resourceGroupName string = resourceGroup.name
output resourceGroupId string = resourceGroup.id
