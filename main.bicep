targetScope = 'subscription'

@description('Environment name (dev/prod)')
param environmentName string

@description('Azure region for resource deployment')
param location string

@description('Azure AD tenant ID')
param tenantId string

@secure()
@description('SQL Server administrator login password')
param sqlAdminLogin string

@secure()
@description('SQL Server administrator login password')
param sqlAdminPassword string

// Variables
var resourceGroupName = 'rg-${environmentName}'
var sqlServerName = 'sql-${environmentName}'
var databaseName = 'db-${environmentName}'
var planName = 'plan-${environmentName}'
var apiAppName = 'api-${environmentName}'
var frontendAppName = 'app-${environmentName}'
var signalRName = 'signalr-${environmentName}'
var communicationServiceName = 'comm-${environmentName}'
var keyVaultName = 'kv-${environmentName}'

// Create resource group
module rg 'modules/resourceGroup.bicep' = {
  name: 'resourceGroup-deployment'
  params: {
    name: resourceGroupName
    location: location
  }
}

module sql 'modules/sqlServer.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'sql-server-deployment'
  params: {
    serverName: sqlServerName
    administratorLogin: sqlAdminLogin
    administratorLoginPassword: sqlAdminPassword
    location: location
  }
  dependsOn: [
    rg
  ]
}

module db 'modules/sqlDatabase.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'sql-database-deployment'
  params: {
    databaseName: databaseName
    serverName: sql.outputs.serverName
    skuName: 'Basic'
    skuTier: 'Basic'
    location: location
  }
  dependsOn: [
    sql
  ]
}

module appServicePlan 'modules/appServicePlan.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'app-service-plan-deployment'
  params: {
    planName: planName
    location: location
    skuName: 'B1'
    skuTier: 'Basic'
    skuSize: 'B1'
  }
  dependsOn: [
    rg
  ]
}

module apiApp 'modules/webApp.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'api-app-deployment'
  params: {
    siteName: apiAppName
    appServicePlanId: appServicePlan.outputs.planId
    location: location
  }
  dependsOn: [
    appServicePlan
  ]
}

module frontendApp 'modules/webApp.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'frontend-app-deployment'
  params: {
    siteName: frontendAppName
    appServicePlanId: appServicePlan.outputs.planId
    location: location
  }
  dependsOn: [
    appServicePlan
  ]
}

module signalR 'modules/signalR.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'signalr-deployment'
  params: {
    name: signalRName
    location: location
    skuName: 'Free_F1'
    skuTier: 'Free'
  }
  dependsOn: [
    rg
  ]
}

module communication 'modules/communicationService.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'communication-service-deployment'
  params: {
    name: communicationServiceName
    location: 'global'
  }
  dependsOn: [
    rg
  ]
}

module keyVault 'modules/keyVault.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'key-vault-deployment'
  params: {
    vaultName: keyVaultName
    location: location
    tenantId: tenantId
    skuName: 'standard'
  }
  dependsOn: [
    rg
  ]
}
