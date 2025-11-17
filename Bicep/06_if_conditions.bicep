// Variable defined
var prefix = 'dev'

// Variable array
var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]

// resource deployment
resource storageAccount1 'Microsoft.Storage/storageAccounts@2024-01-01' = if (prefix == 'prod') {
  name: '20251115bicepprod'
  location: first(regions)  // using bicep inbuilt function
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource storageAccount2 'Microsoft.Storage/storageAccounts@2024-01-01' = if (prefix == 'dev') {
  name: '20251115bicepdev'
  location: last(regions)  // using bicep inbuilt function
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
