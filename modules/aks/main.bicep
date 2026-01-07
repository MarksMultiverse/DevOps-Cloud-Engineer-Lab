param clusterName string = 'aks-devops-lab'
param location string = 'westeurope'
param dnsPrefix string = 'aks-devops-lab'
param nodeCount int = 2
param vmSize string = 'Standard_D2s_v3'
param subnetId string
param tags object = {
  Project: 'devops-cloud-engineer-lab'
  Responsible: 'mark.tilleman@cegeka.com'
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2024-08-01' = {
  name: clusterName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: dnsPrefix
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: nodeCount
        vmSize: vmSize
        mode: 'System'
        osType: 'Linux'
        type: 'VirtualMachineScaleSets'
        vnetSubnetID: subnetId
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      serviceCidr: '10.1.0.0/16'
      dnsServiceIP: '10.1.0.10'
    }
  }
}

output clusterId string = aksCluster.id
output clusterName string = aksCluster.name
output clusterFqdn string = aksCluster.properties.fqdn
output kubeletIdentityObjectId string = aksCluster.properties.identityProfile.kubeletidentity.objectId
