targetScope='subscription'

param resourceGroupName string = 'rg-devops-cloud-engineer-lab'
param location string = 'westeurope'
param tags object = {
  Project: 'devops-cloud-engineer-lab'
  Responsible: 'mark.tilleman@cegeka.com'
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

output resourceGroupName string = resourceGroup.name
