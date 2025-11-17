// Azure Bicep Template

// @<decorator>(<argument>)
// metadata <metadata-name> = ANY

// targetScope = '<scope>'

// @<decorator>(<argument>)
// type <user-defined-data-type-name> = <type-expression>

// @<decorator>(<argument>)
// func <user-defined-function-name> (<argument-name> <data-type>, <argument-name> <data-type>, ...) <function-data-type> => <expression>


metadata description = 'Creates a storage account and a web app'


@description('The prefix to use for the storage account name.')
@minLength(3)
@maxLength(11)
param storagePrefix string


@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_ZRS'
  'Premium_LRS'
])
@description('Storage Account type')
param storageAccountType string = 'Standard_LRS'


@description('Storage SKU')
param storageSKU string = 'Standard_LRS'
// param location string = resourceGroup().location


@description('Location for all resources.')
param location string = resourceGroup().location


// var uniqueStorageName = '${storagePrefix}${uniqueString(resourceGroup().id)}'
var uniqueStorageName = 'store${uniqueString(resourceGroup().id)}'


// @<decorator>(<argument>)
@description('StorageAccount Creation')
resource stg 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: uniqueStorageName
  location: location
  sku: {
    name: storageSKU
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}


resource exampleStorage 'Microsoft.Storage/storageAccounts@2023-04-01' = {
  name: storagePrefix
  location: location
  sku: {
    name: storageAccountType
  }
  kind: 'StorageV2'
  properties: {}
}


// @<decorator>(<argument>)
// module webModule './webApp.bicep' = {
//   name: 'webDeploy'
//   params: {
//     skuName: 'S1'
//     location: location
//   }
// }


output storageAccountName string = uniqueStorageName

