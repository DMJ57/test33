@description('Resources location')
param location string = resourceGroup().location

//----------- Storage Account Parameters ------------
@description('Function Storage Account name')
@minLength(3)
@maxLength(24)
param storageAccountName string

@description('Function Storage Account SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GZRS'
  'Standard_RAGZRS'
])
param storageAccountSku string = 'Standard_LRS'

var buildNumber = uniqueString(resourceGroup().id)

//----------- Storage Account Deployment ------------
module storageAccountModule 'modules/storage.bicep' = {
  name: 'stvmdeploy-${buildNumber}'
  params: {
    name: storageAccountName
    sku: storageAccountSku
    location: location
  }
}
