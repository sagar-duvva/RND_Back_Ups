resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'sastoreci09062025'
  location: 'centralindia'
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
}
