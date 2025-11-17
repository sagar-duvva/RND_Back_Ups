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
  name: '${nameprefix}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressprefix
      ]
    }
    subnets: [ for i in range(1, 5): {
        name: '${nameprefix}-subnet${i}'
        properties: {
          addressPrefix: cidrSubnet(addressprefix, 24, i)
        }
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: '${nameprefix}-publicip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}



resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${nameprefix}-nic'
  location: location
  dependsOn: [
    virtualNetwork
  ]
  properties: {
    ipConfigurations: [
      {
        name: '${nameprefix}-nic-IPconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'prod-vnet', 'prod-subnet1')
          }
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
  }
}
