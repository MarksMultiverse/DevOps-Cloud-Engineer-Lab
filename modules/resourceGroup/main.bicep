targetScope='subscription'

param resourceGroupName string = 'rg-devops-cloud-engineer-lab'
param location string = 'westeurope'
param ownerObjectId string = '133e1112-c5f5-41b3-b660-f70038785ccf'
param tags object = {
  Project: 'devops-cloud-engineer-lab'
  Responsible: 'mark.tilleman@cegeka.com'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

resource ownerRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(resourceGroup.id, ownerObjectId, 'Owner')
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '8e3af657-a8ff-443c-a75c-2fe8c4bcb635')
    principalId: ownerObjectId
    principalType: 'ServicePrincipal'
  }
}

output resourceGroupName string = resourceGroup.name
