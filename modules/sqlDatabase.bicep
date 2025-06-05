@description('Name of the SQL Database')
param databaseName string

@description('Name of the SQL Server')
param serverName string

@description('The name of the SKU')
@allowed([
  'Basic'
  'Standard'
  'Premium'
  'GP_Gen5'
  'BC_Gen5'
])
param skuName string

@description('The tier of the SKU')
@allowed([
  'Basic'
  'Standard'
  'Premium'
  'GeneralPurpose'
  'BusinessCritical'
])
param skuTier string

@description('SQL Database collation')
param collation string = 'SQL_Latin1_General_CP1_CI_AS'

@description('Location for the SQL Database')
param location string

resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' existing = {
  name: serverName
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
  properties: {
    collation: collation
    requestedBackupStorageRedundancy: 'Local'
    zoneRedundant: false
  }
  tags: {
    deployedBy: 'Bicep'
  }
}

output databaseName string = sqlDatabase.name
output databaseId string = sqlDatabase.id
