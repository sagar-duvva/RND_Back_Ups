@description('Please specify name prefix for resources')
param nameprefix string = 'prod'

@description('specify location')
@allowed([
  'centralindia'
  'southindia'
  'eastus'
])
param location string = 'centralindia'


var addressprefix = '10.0.0.0/16'


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: '${nameprefix}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressprefix
      ]
    }
    subnets: [ for i in range(1, 5): {
        name: '${nameprefix}-subnet${i}'
        properties: {
          addressPrefix: cidrSubnet(addressprefix, 24, i)
        }
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: '${nameprefix}-publicip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}



resource saadvanced 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: '${nameprefix}saci1709202501'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource saadvancedfileshare 'Microsoft.Storage/storageAccounts/fileServices@2025-01-01' = {
  parent: saadvanced
  name: 'default'
  properties: {
    shareDeleteRetentionPolicy:{
      enabled: false
      allowPermanentDelete: true
    }
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: '${nameprefix}-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allowRDP'
        properties: {
          description: 'Allow RDP'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}


resource networkInterface 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: '${nameprefix}-nic'
  location: location
  dependsOn: [
    virtualNetwork
  ]
  properties: {
    ipConfigurations: [
      {
        name: '${nameprefix}-nic-IPconfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', 'prod-vnet', 'prod-subnet1')
          }
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}


resource windowsVM 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: '${nameprefix}-appvm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: '${nameprefix}-appvm'
      adminUsername: 'vmadmin'
      adminPassword: 'Passw0rd@123'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: '${nameprefix}-osDisk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri:  saadvanced.properties.primaryEndpoints.blob
      }
    }
  }
}
