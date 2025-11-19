var regions = [
  {
    name: 'eus'
    location: 'eastus'
    addressPrefixes: '10'
  }
  {
    name: 'neu'
    location: 'northeurope'
    addressPrefixes: '20'
  }
  {
    name: 'ci'
    location: 'centralindia'
    addressPrefixes: '30'
  }
]

resource vnet 'Microsoft.Network/virtualNetworks@2024-10-01' = [ for region in regions: {
  name: '${region.name}vnet'
  location: region.location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${region.addressPrefixes}.0.0/16'
      ]
    }
    subnets: [ for i in range(1, 5): {
        name: '${region.name}snet${i}'
        properties: {
          addressPrefix: '10.${region.addressPrefixes}.${i}0.0/24'
        }
      }
    ]
  }
    tags: {
    location : region.location
  }
}]

//output subnets_out array = [for i in regions: vnet[i].properties.subnets]

output vnetnames array = [for (region,i) in regions: vnet[i].name]
output vnetOuts array = [for (region,i) in regions: vnet[i]]
output vnetSnetNames array = [for (region,i) in regions: vnet[i].properties.subnets[i].name]
output vnetSnetIps array = [for (region,i) in regions: vnet[i].properties.subnets[i].properties]
output vnetSnetOuts array = [for (region,i) in regions: vnet[i].properties.subnets]
