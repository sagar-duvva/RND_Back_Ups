// Variable defined
var storageName = '20251115storage'

// resource deployment
resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName       // using Variable defined
  location: 'centralindia'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
