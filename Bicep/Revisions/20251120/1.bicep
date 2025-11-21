param prefix string = 'dev'

var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]

resource devAppServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = if (prefix == 'dev') {
  name: '${prefix}-app-plan'
  location: last(regions)
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource prodAppServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = if (prefix == 'prod') {
  name: '${prefix}-app-plan'
  location: first(regions)
  sku: {
    name: 'F1'
    capacity: 1
  }
}

var appPlanId = (prefix == 'prod') ? '${prodAppServicePlan.id}' : '${devAppServicePlan.id}'

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: 'bicepdemowebapp20251121'
  location: '${prefix == 'dev'} ? ${last(regions)} : ${first(regions)}'
  properties: {
    serverFarmId: appPlanId

  }

}


output locVar string = '${prefix == 'dev'} ? ${last(regions)} : ${first(regions)}'
