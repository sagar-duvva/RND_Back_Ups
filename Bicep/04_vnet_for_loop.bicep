var location = 'centralindia'
var addressprefix = '10.0.0.0/16'
var nameprefix = 'prod'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: '${nameprefix}vnet01'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressprefix
      ]
    }
    subnets: [ for i in range(1, 5): {
        name: '${nameprefix}Subnet${i}'
        properties: {
          addressPrefix: cidrSubnet(addressprefix, 24, i)
        }
      }
    ]
  }
}
