resource PubIP 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'Pubip01'
  location: 'centralindia'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
