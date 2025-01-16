@description('The name of the key vault')
param keyVaultName string

@secure()
@description('SFTP key for PIM feed')
param secretName string

@secure()
@description('AWS S3 access key ID for PIM feed')
param secretValue string

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

resource keyVaultSecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: secretName
  properties: {
    value: secretValue
  }
}
