// resource deployment
resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: '20251115storage'
  location: 'centralindia'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
