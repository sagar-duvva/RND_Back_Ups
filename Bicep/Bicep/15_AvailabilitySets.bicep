resource availabilitySet01 'Microsoft.Compute/availabilitySets@2020-12-01' = {
  name: 'availabilitySet01'
  location: 'centralindia'
  sku: {
     name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount:3
    platformUpdateDomainCount: 5

  }
}
