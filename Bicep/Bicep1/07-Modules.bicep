param name string = 'toyapp${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
var appServicePlanName = '${name}-webapp'


@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lowercase letters and numbers. The name must be unique across Azure.')
param storageAccountName string = 'store${uniqueString(resourceGroup().id)}'


@allowed([
  'nonprod'
  'prod'
])
param environmentType string



var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
// (environmentType == 'prod') evaluates to a Boolean (true or false) value,? is called a ternary operator, and it evaluates an if/then statement.
// The value after the ? operator is used if the expression is true. If the expression evaluates to false, the value after the colon (:) is used.
// For the storageAccountSkuName variable, if the environmentType parameter is set to prod, then use the Standard_GRS SKU. Otherwise, use the Standard_LRS SKU

var appServicePlanSkuName = (environmentType == 'prod') ? 'P2V3' : 'F1'

resource appServicePlan 'Microsoft.Web/serverFarms@2023-12-01' = {
  name: '${name}-plan'
  location: location
  sku: {
    name: appServicePlanSkuName
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


module SAModule '07SAModule.bicep' = {
  name: 'SA-Module'
  params: {
    SAName: storageAccountName
    loc: location
    SkuName: storageAccountSkuName
  }
}


output appServiceAppName string = appServiceApp.name

output ipFqdn string = appServiceApp.properties.defaultHostName
