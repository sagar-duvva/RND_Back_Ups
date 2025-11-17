param location string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet001'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet001'
        properties: {
          addressPrefix: '10.0.100.0/24'
        }
      }
      {
        name: 'snet002'
        properties: {
          addressPrefix: '10.0.200.0/24'
        }
      }
    ]
  }
}
