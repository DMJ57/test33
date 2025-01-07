@description('Resources location')
param location string = resourceGroup().location

//----------- Function App Parameters ------------


//----------- Storage Account Parameters ------------
@description('Function Storage Account name')
@minLength(3)
@maxLength(24)
param storageAccountName string = 'komatsu33'

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

//----------- App Service Deployment ------------

param appServicePlanName string = 'myAppServicePlan'
param appServiceName string = 'myAppService'

module appServicePlan 'modules/appservice.bicep' = {
  name: 'appServicePlanDeployment'
  params: {
    location: location
    appServicePlanName: appServicePlanName
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.outputs.appServicePlanId  // Referencing the App Service Plan ID output from the module
      }
}



