resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = [for i in range(1,4): {
  name: 'demosastore150920250${i}'
  location: 'Central India'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}
]
