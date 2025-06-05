@description('Name of the SQL Server')
param serverName string

@description('Administrator login for the SQL Server')
param administratorLogin string

@description('Administrator login password for the SQL Server')
@secure()
param administratorLoginPassword string

@description('Location for the SQL Server')
param location string

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: serverName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
  tags: {
    deployedBy: 'Bicep'
  }
}

output serverName string = sqlServer.name
output serverId string = sqlServer.id
output serverFqdn string = sqlServer.properties.fullyQualifiedDomainName
