param prefix string = 'dev'

var regions = [
  'eastus'
  'northeurope'
  'centralindia'
]

//var  locVar = '${prefix == 'dev'} ? ${last(regions)} : ${first(regions)}'
var  locVar = (prefix == 'dev') ? last(regions) : first(regions)

output locVarOut string = locVar
