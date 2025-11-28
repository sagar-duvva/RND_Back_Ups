@description('Environment name')
@allowed([
  'featurebranch'
  'dev'
  'test'
  'uat'
  'production'
])
param environmentName string = 'dev'
var createStorageAccount = environmentName != 'featurebranch'


@description('Storage Account type')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageAccountType string = 'Standard_LRS'

@description('Location for the storage account.')
param location string = resourceGroup().location

@description('The name of the Storage Account')
param storageAccountName string = 'storageaccount1'

// if createStorageAccount is true, then only the storage account is created.
resource sa 'Microsoft.Storage/storageAccounts@2021-06-01' = if (createStorageAccount) {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
  properties: {}
}

output storageAccountName string = storageAccountName
output storageAccountId string = sa.id
