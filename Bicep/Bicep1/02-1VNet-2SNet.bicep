resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet01'
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'snet01'
        properties: {
          addressPrefix: '10.0.10.0/24'
        }
      }
      {
        name: 'snet02'
        properties: {
          addressPrefix: '10.0.20.0/24'
        }
      }
    ]
  }
}
