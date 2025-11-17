resource saadvanced 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'demosastore1509202501'
  location: 'Central India'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource saadvancedfileshare 'Microsoft.Storage/storageAccounts/fileServices@2025-01-01' = {
  parent: saadvanced
  name: 'default'
  properties: {
    shareDeleteRetentionPolicy:{
      enabled: false
      allowPermanentDelete: true
    }
  }
}
