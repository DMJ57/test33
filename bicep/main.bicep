param location string = 'eastus'
param environment string = 'dev'

module storage './modules/storage.bicep' = {
  name: 'storageModule'
  params: {
    location: 'eastus'
    storageName: 'mystorage33'
  }
}

module functionapp './modules/functionapp.bicep' = {
  name: 'functionAppModule'
  params: {
    location: 'eastus'
    functionName: 'komastufunapp'
  }
}

