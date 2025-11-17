@description('Please specify name prefix for resources')
param nameprefix string = 'prod'

@description('specify location')
@allowed([
  'centralindia'
  'southindia'
  'eastus'
])
param location string = 'centralindia'


var addressprefix = '10.0.0.0/16'


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
        name: '${nameprefix}subnet${i}'
        properties: {
          addressPrefix: cidrSubnet(addressprefix, 24, i)
        }
      }
    ]
  }
}
