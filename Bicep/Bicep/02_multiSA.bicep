resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = [ for i in range(0,3): {
  name: 'sastoreci09062025${i}'
  // name: '${i}sastoreci09062025'
  location: 'centralindia'
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
]
