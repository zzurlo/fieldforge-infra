@description('Name of the Web App')
param siteName string

@description('Resource ID of the App Service Plan')
param appServicePlanId string

@description('Location for the Web App')
param location string

resource webApp 'Microsoft.Web/sites@2022-09-01' = {
  name: siteName
  location: location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
      ftpsState: 'FtpsOnly'
    }
  }
}

output webAppName string = webApp.name
output defaultHostName string = webApp.properties.defaultHostName
