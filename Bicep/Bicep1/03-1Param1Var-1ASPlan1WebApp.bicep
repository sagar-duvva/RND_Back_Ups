param name string = 'toyapp${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
var appServicePlanName = '${name}-webapp'

resource appServicePlan 'Microsoft.Web/serverFarms@2023-12-01' = {
  name: '${name}-plan'
  location: location
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
  name: appServicePlanName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
