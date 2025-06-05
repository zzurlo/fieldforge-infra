@description('Name of the Communication Service')
param name string

@description('Location for the Communication Service')
@allowed([
  'global'
  'africa'
  'asia'
  'australia'
  'europe'
  'india'
  'southamerica'
  'unitedstates'
])
param location string = 'global'

resource communicationService 'Microsoft.Communication/communicationServices@2023-04-01' = {
  name: name
  location: location
  properties: {
    dataLocation: location
    linkedDomains: []
  }
}

output communicationServiceName string = communicationService.name
output communicationServiceEndpoint string = communicationService.properties.hostName
output primaryConnectionString string = communicationService.listKeys().primaryConnectionString
