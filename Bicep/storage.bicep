//parameter defined
@minLength(5)
@maxLength(23)
param storageName string

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

// output defined
output storageEndpoint object = storageAccount.properties.primaryEndpoints
