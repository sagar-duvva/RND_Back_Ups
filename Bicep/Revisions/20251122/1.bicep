param prefix string = 'dev'

var location = [
  'eastus'
  'centralindia'
]

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'Vnet-${prefix}'
  location: (prefix == 'prod') ? first(location) : last(location)
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [ for i in range(0, 50): {
        name: 'Snet-${prefix}-${i}'
        properties: {
          addressPrefix: '10.0.${i}0.0/24'
        }
      }
    ]
  }
}

resource storageaccountProd 'Microsoft.Storage/storageAccounts@2021-02-01' = if (prefix == 'Prod') {
  name: 'bicepsademoprod202511'
  location: first(location)
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}


