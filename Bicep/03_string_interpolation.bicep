// Variable defined
var prefix = 'prod'
var storageName = '${prefix}20251115storage' // String interpolation

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
