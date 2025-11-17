// Variable defined
var prefix = 'prod'
var storageName = '${prefix}20251115storage' // String interpolation

// Variable array
var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]

// resource deployment
resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: storageName
  location: first(regions)  // using bicep inbuilt function
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
