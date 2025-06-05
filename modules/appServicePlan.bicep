@description('Name of the App Service Plan')
param planName string

@description('Location for the App Service Plan')
param location string

@description('The name of the SKU for the App Service Plan')
param skuName string

@description('The tier of the SKU for the App Service Plan')
param skuTier string

@description('The size of the SKU for the App Service Plan')
param skuSize string

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: planName
  location: location
  sku: {
    name: skuName
    tier: skuTier
    size: skuSize
  }
  properties: {
    reserved: false
  }
}

output planId string = appServicePlan.id
