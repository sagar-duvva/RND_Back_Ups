// Description :- This template deploys a AppServicePlan and a WebApp based on given prefix

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


output appdetail string = (prefix == 'prod') ? prodAppServicePlan.properties.freeOfferExpirationTime : devAppServicePlan.properties.freeOfferExpirationTime
// var appPlanId = (prefix == 'prod') ? prodAppServicePlan.id : devAppServicePlan.id

resource webApplication 'Microsoft.Web/sites@2021-01-15' = {
  name: 'bicepdemowebapp20251121'
  location: (prefix == 'dev') ? last(regions) : first(regions)
  properties: {
    serverFarmId: (prefix == 'prod') ? prodAppServicePlan.id : devAppServicePlan.id
  }
}


output locationOut string = (prefix == 'dev') ? last(regions) : first(regions)
output appIdOut string = (prefix == 'prod') ? prodAppServicePlan.id : devAppServicePlan.id
//output locVar1 string = (prefix == 'dev') ? last(regions) : first(regions)
