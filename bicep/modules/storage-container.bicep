@description('Name of existing Storage Account')
param storageAccountName string = 'komkxintdataeusdevdl'

@description('Array of container Names to create')
param containerNames array = [
  'container1'
  'container2'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' existing = {
  name : storageAccountName
}

@description('Create containers in existing storage account')
resource storageContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = [for containerName in containerNames:{
  name: '${storageAccount.name}/default/${containerName}'
  properties:{
    publicAccess : 'None'
  }
}]
