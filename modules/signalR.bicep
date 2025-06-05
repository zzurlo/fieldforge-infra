@description('Name of the SignalR Service')
param name string

@description('Location for the SignalR Service')
param location string

@description('The name of the SKU for SignalR Service')
@allowed([
  'Free_F1'
  'Standard_S1'
  'Premium_P1'
])
param skuName string

@description('The tier of the SKU for SignalR Service')
@allowed([
  'Free'
  'Standard'
  'Premium'
])
param skuTier string

resource signalR 'Microsoft.SignalRService/signalR@2022-02-01' = {
  name: name
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: 1
  }
  properties: {
    features: [
      {
        flag: 'ServiceMode'
        value: 'Default'
      }
    ]
    cors: {
      allowedOrigins: [
        '*'
      ]
    }
  }
}

output signalRConnectionString string = signalR.listKeys().primaryConnectionString
output signalRServiceId string = signalR.id
