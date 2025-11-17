
param shortAppName string = 'toy'
param shortEnvironmentName string = 'prod'
param appServiceAppName string = '${shortAppName}${shortEnvironmentName}${uniqueString(resourceGroup().id)}'

module storageModule 'storage.bicep' = {
  name: 'storageMoudle'
  params: {
    storageName: appServiceAppName
  }
}
