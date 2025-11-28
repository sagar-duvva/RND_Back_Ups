// param stage string = 'prod'

// var isProd = stage == 'prod'
// var isTest = stage == 'test'
// var isDev = stage == 'dev'

// resource saProd 'Microsoft.Storage/storageAccounts@2022-09-01' existing = if (isProd) {
//   name: 'prodstorageaccounttp'
// }

// resource saTest 'Microsoft.Storage/storageAccounts@2022-09-01' existing = if (isTest) {
//   name: 'teststorageaccounttp'
// }

// resource saDev 'Microsoft.Storage/storageAccounts@2022-09-01' existing = if (isDev) {
//   name: 'devstorageaccounttp'
// }


// supports multi-line and multiple conditions
// output saName string = isProd ? saProd.name 
//   : isTest ? saTest.name 
//   : isDev ? saDev.name
//   : 'unknown'

// output varout string = isProd ? saProd

// var res = isProd ? isProd : isDev
// var res1 = isProd ? isDev : isTest ? isProd : 'devResource'
// output resOut string = res
// output res1Out string = res1

// condition ? true-value : false-value
param initValue bool = true

output outValue string = (initValue == 'prod') ? 'true value' : 'false value'



