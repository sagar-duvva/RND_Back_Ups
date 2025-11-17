resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'pub-ip'
  location: 'southindia'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
