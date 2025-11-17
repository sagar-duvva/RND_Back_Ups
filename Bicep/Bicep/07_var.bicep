var vnet = 'vnet01'
var location = 'central india'
var addressPrefix = '10.0.0.0/16'


resource vnet01 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnet
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [for i in range(1,10): {
      name: 'Subnet${i}'
      properties: {
        addressPrefix: cidrSubnet(addressPrefix, 24, i)
      }
    }
    ]
  }
}
