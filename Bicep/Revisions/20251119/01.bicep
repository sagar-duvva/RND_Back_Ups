var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]

resource vnet 'Microsoft.Network/virtualNetworks@2024-10-01' = [ for region in regions: {
  name: '${region}vnet'
  location: region
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [ for i in range(1, 5): {
        name: '${region}snet${i}'
        properties: {
          addressPrefix: '10.0.${i}0.0/24'
        }
      }
    ]
  }
}]

//output subnets_out array = [for i in regions: vnet[i].properties.subnets]

output vnetnames array = [for (region,i) in regions: vnet[i].name]
output vnetsubnets array = [for (region,i) in regions: vnet[i].properties.subnets]
