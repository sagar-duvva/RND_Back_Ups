targetScope = 'subscription'

var rgName = 'DeployedFromBicepRG'

resource myNewRG 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: rgName
  location: 'centralindia'
}


module storageModule 'storage.bicep' = {
  name: 'storageMoudle'
  scope: resourceGroup(myNewRG.name)
  params: {
    storageName: '20251115module'
  }
}
