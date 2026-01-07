param vnetName string = 'vnet-devops-lab'
param location string = 'westeurope'
param addressPrefix string = '10.0.0.0/16'
param tags object = {
  Project: 'devops-cloud-engineer-lab'
  Responsible: 'mark.tilleman@cegeka.com'
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: 'subnet-default'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'subnet-aks'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

output vnetId string = virtualNetwork.id
output vnetName string = virtualNetwork.name
output aksSubnetId string = virtualNetwork.properties.subnets[1].id
