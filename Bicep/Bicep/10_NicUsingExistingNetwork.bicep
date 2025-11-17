resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'Nic01'
  location: 'centralindia'
  properties: {
    ipConfigurations: [
      {
        name: 'name'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'appnetwork', 'subnet1')
          }
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses','Pubip01')
          }
        }
      }
    ]
  }
}
