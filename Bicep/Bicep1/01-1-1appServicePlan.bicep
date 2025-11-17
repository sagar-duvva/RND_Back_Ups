resource appServicePlan 'Microsoft.Web/serverFarms@2023-12-01' = {
  name: 'toy-product-launch-plan'
  location: 'centralindia'
  sku: {
    name: 'F1'
  }
}
