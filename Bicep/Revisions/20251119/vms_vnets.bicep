
var location = resourceGroup().location

resource Identifier 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: 'vnet01'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet1'
        properties: {
          addressPrefix: '10.0.10.0/24'
        }
      }
      {
        
      }
    ]
  }
}

