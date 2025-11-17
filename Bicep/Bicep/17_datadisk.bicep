resource datadisk01 'Microsoft.Compute/disks@2024-03-02' = {
  name: 'datadisk01'
  location: 'centralindia'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 10
  }
}
