var location = 'centralindia'


// App Service Plan for WebApp
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'appplan01'
  location: location
  sku: {
    name: 'F1'
    capacity: 1
  }
}


//Web App with .net frame work v6.0 version
resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: 'webapptue202506100923'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v6.0'
    }
  }
}
