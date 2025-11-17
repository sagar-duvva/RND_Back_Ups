resource storageAccount01 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: 'testsastoreapp06082025'
  location: 'centralindia'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
