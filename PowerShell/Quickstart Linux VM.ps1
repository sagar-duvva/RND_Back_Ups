## Quickstart: Create a Linux virtual machine in Azure with PowerShell

# Create a resource group
New-AzResourceGroup -Name 'myResourceGroup' -Location 'EastUS'

# Create a virtual machine
New-AzVm `
    -ResourceGroupName 'myResourceGroup' `
    -Name 'myVM' `
    -Location 'East US' `
    -image Debian11 `
    -size Standard_B2s `
    -PublicIpAddressName myPubIP `
    -OpenPorts 80 `
    -GenerateSshKey `
    -SshKeyName mySSHKey

New-AzVm -ResourceGroupName 'myResourceGroup' -Name 'myVM' -Location 'East US' -image Debian11 -size Standard_B2s -PublicIpAddressName myPubIP -OpenPorts 80 -GenerateSshKey -SshKeyName mySSHKey

# Install NGINX
Invoke-AzVMRunCommand `
   -ResourceGroupName 'myResourceGroup' `
   -Name 'myVM' `
   -CommandId 'RunShellScript' `
   -ScriptString 'sudo apt-get update && sudo apt-get install -y nginx'

Invoke-AzVMRunCommand -ResourceGroupName 'myResourceGroup' -Name 'myVM' -CommandId 'RunShellScript' -ScriptString 'sudo apt-get update && sudo apt-get install -y nginx'

# View the web server in action
Get-AzPublicIpAddress -Name myPubIP -ResourceGroupName myResourceGroup | select "IpAddress"

# Clean up resources
Remove-AzResourceGroup -Name 'myResourceGroup'