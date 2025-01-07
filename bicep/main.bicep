param location string = 'eastus'
param environment string = 'dev'

module storage './modules/storage.bicep' = {
  name: 'storageModule'
  params: {
    location: location
    storageName: 'mystorage${environment}'
  }
}

module functionapp './modules/functionapp.bicep' = {
  name: 'functionAppModule'
  params: {
    location: location
    functionName: 'komastufunapp${environment}'
  }
}

