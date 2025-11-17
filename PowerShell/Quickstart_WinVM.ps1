
<#
Quickstart: Create a Windows virtual machine in Azure with PowerShell
https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-powershell
#>

# Create resource group
New-AzResourceGroup -Name 'staging-grp1' -Location 'Central India'

# Create virtual machine
New-AzVm `
-ResourceGroupName 'staging-grp1' `
-Name 'myVM' `
-Location 'CentralIndia' `
-Size 'Standard_D2s_v3'
-Image 'MicrosoftWindowsServer:WindowsServer:2022-datacenter-azure-edition:latest' `
-VirtualNetworkName 'myVnet' `
-SubnetName 'mySubnet' `
-SecurityGroupName 'myNetworkSecurityGroup' `
-PublicIpAddressName 'myPublicIpAddress' `
-OpenPorts 80,3389

# Install web server
Invoke-AzVMRunCommand -ResourceGroupName 'staging-grp1' -VMName 'myVM' -CommandId 'RunPowerShellScript' -ScriptString 'Install-WindowsFeature -Name Web-Server -IncludeManagementTools'

# Clean up resources
Remove-AzResourceGroup -Name 'staging-grp1' -Force -Verbose