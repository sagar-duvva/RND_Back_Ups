param name string = 'toyapp${uniqueString(resourceGroup().id)}'

resource appServicePlan 'Microsoft.Web/serverFarms@2023-12-01' = {
  name: '${name}-plan'
  location: 'centralindia'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2023-12-01' = {
  name: '${name}-webapp'
  location: 'centralindia'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
