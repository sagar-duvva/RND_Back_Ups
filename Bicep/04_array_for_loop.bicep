// Variable defined
var prefix = 'prod'
var storageName = '${prefix}20251115storage' // String interpolation

// Variable array
var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]


// using loop == for eachitem in items:
// generating index out of loop == (eachitem,i)
resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = [for (region,i) in regions: {
  name: '${storageName}${i}'       // using loop index with String interpolation
  location: region        // using loop item
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}]
