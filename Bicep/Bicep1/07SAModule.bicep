param SAName string
param loc string
param SkuName string

resource storageAccount01 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: SAName
  location: loc
  sku: {
    name: SkuName
  }
  kind: 'StorageV2'
}
