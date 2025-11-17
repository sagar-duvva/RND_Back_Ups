resource SAAdvance 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'sastoreci090620250647pm'
  location: 'centralindia'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Cool'
    allowBlobPublicAccess: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules: [
        {
          action: 'Allow'
          value: '60.243.185.225'
        }
      ]
    }
  }
}

resource SAAdvance_default 'Microsoft.Storage/storageAccounts/blobServices@2024-01-01' = {
  parent: SAAdvance
  name: 'default'
  properties: {
    isVersioningEnabled: true
  }
}
