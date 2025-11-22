param prefix string = 'dev'

var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]

//var  locVar = '${prefix == 'dev'} ? ${last(regions)} : ${first(regions)}'
var  locVar = (prefix == 'dev') ? last(regions) : first(regions)

output locVarOut string = locVar


// param stage string = 'prod'

// var isProd = stage == 'prod'
// var isTest = stage == 'test'
// var isDev = stage == 'dev'

// resource saProd 'Microsoft.Storage/storageAccounts@2022-09-01' existing = if (isProd) {
//   name: 'prodstorageaccounttp'
// }

// resource saTest 'Microsoft.Storage/storageAccounts@2022-09-01' existing = if (isTest) {
//   name: 'teststorageaccounttp'
// }

// resource saDev 'Microsoft.Storage/storageAccounts@2022-09-01' existing = if (isDev) {
//   name: 'devstorageaccounttp'
// }


// supports multi-line and multiple conditions
// output saName string = isProd ? saProd.name 
//   : isTest ? saTest.name 
//   : isDev ? saDev.name
//   : 'unknown'

// output varout string = isProd ? saProd

// var res = isProd ? isProd : isDev
// var res1 = isProd ? isDev : isTest ? isProd : 'devResource'
// output resOut string = res
// output res1Out string = res1

// condition ? true-value : false-value
param initValue bool = true

output outValue string = (initValue == 'prod') ? 'true value' : 'false value'



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
