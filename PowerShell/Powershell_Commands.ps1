
## Creating New Resource Group

New-AzResourceGroup -Name "RGCI" -Location 'Central India' -Verbose


$rgname="RGCI"
$locCI='Central India'
New-AzResourceGroup -Name $rgname -Location $locCI -Verbose

Get-AzResourceGroup

Get-AzResourceGroup | select ResourceGroupName,Location | FL #Output Format List

Get-AzResourceGroup | select ResourceGroupName,Location | FT #Output Format Table

## Creating Virtual Network

$rgname="RGCI"
$locCI='Central India'
$VNetName="app-VNet"
$iprang="10.0.0.0/16"

New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname -Location $locCI -AddressPrefix $iprang

Get-AzVirtualNetwork
Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname

$VNetDetails=Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname
$VNetDetails | select AddressSpaceText | fl
$VNetDetails | select *

## Creating Subnets on existing Virtual Network


$rgname="RGCI"
$locCI='Central India'
$VNetName="app-VNet"
$iprang="10.0.0.0/16"
$SNEtName="SNetA"
$SNetIPRane="10.0.0.0/24"

$VNetDetails=Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname

$VNetDetails | select *

Add-AzVirtualNetworkSubnetConfig -Name $SNEtName -VirtualNetwork $VNetDetails -AddressPrefix $SNetIPRane

$VNetDetails | select *
$VNetDetails | select Subnets
$VNetDetails | select SubnetsText | fl

$VNetDetails | Set-AzVirtualNetwork




## Creating Virtual Network with Subnets

$rgname="RGCI"
$locCI='Central India'
$VNetName="app-VNet"
$iprang="10.0.0.0/16"
$SNEtName="SNetA"
$SNetIPRane="10.0.0.0/24"

$subnet = New-AzVirtualNetworkSubnetConfig -Name $SNEtName -AddressPrefix $SNetIPRane

New-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname -Location $locCI -AddressPrefix $iprang -Subnet $subnet



Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname | select *




## Example : Create a virtual network with two subnets -----

New-AzResourceGroup -Name TestResourceGroup -Location centralus
$frontendSubnet = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "10.0.1.0/24"
$backendSubnet  = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "10.0.2.0/24"
New-AzVirtualNetwork -Name MyVirtualNetwork -ResourceGroupName TestResourceGroup -Location centralus -AddressPrefix "10.0.0.0/16" -Subnet $frontendSubnet,$backendSubnet


## Example : Create a virtual network with a subnet referencing a network security group

New-AzResourceGroup -Name TestResourceGroup -Location centralus
$rdpRule              = New-AzNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 100 -SourceAddressPrefix Internet `
-SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$networkSecurityGroup = New-AzNetworkSecurityGroup -ResourceGroupName TestResourceGroup -Location centralus -Name "NSG-FrontEnd" -SecurityRules $rdpRule
$frontendSubnet       = New-AzVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix "10.0.1.0/24" -NetworkSecurityGroup $networkSecurityGroup
$backendSubnet        = New-AzVirtualNetworkSubnetConfig -Name backendSubnet  -AddressPrefix "10.0.2.0/24" -NetworkSecurityGroup $networkSecurityGroup
New-AzVirtualNetwork -Name MyVirtualNetwork -ResourceGroupName TestResourceGroup -Location centralus -AddressPrefix "10.0.0.0/16" -Subnet $frontendSubnet,$backendSubnet




# Creating Network Interface


$rgname="RGCI"
$locCI='Central India'
$VNetName="app-VNet"
$iprang="10.0.0.0/16"
$SNEtName="SNetA"
$SNetIPRane="10.0.0.0/24"
$NICname="NIC01"


$VNetDetails=Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname
$SNetDetails=Get-AzVirtualNetworkSubnetConfig -VirtualNetwork $VNetDetails -Name $SNEtName

New-AzNetworkInterface -Name $NICname -ResourceGroupName $rgname -Location $locCI -SubnetId $SNetDetails.Id -IpConfigurationName 'NIC01ipconfig'

Get-AzNetworkInterface | fl
Get-AzNetworkInterface -Name $NICname | fl




## Deploying Public IP

$rgname="RGCI"
$locCI='Central India'
$PipName="Pip01"

New-AzPublicIpAddress -Name $PipName -ResourceGroupName $rgname -Location $locCI -Sku Standard -AllocationMethod Static
New-AzPublicIpAddress -Name $PipName -ResourceGroupName $rgname -Location $locCI -Sku Standard -Tier Regional -AllocationMethod Static


### NSGs

$rgname="RGCI"
$locCI='Central India'
$NGSname="NSG-FrontEnd"

$rdpRule1=New-AzNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow RDP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 100 -SourceAddressPrefix Internet `
-SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389

$httpRule1=New-AzNetworkSecurityRuleConfig -Name rdp-rule -Description "Allow HTTP" -Access Allow -Protocol Tcp `
-Direction Inbound -Priority 110 -SourceAddressPrefix Internet `
-SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 80

New-AzNetworkSecurityGroup -ResourceGroupName $rgname -Location $locCI -Name $NGSname -SecurityRules $rdpRule1, $httpRule1



### Adding Data Disk to Existing VM

$VMname="AppVM"
$rgname="RGCI"
$Diskname="datadisk01"

$vmdetails=Get-AzVM -ResourceGroupName $rgname -Name $VMname

$vmdetails | Add-AzVMDataDisk -Name $Diskname -DiskSizeInGB 16 -CreateOption Empty -Lun 0

$vmdetails | Update-AzVM




## Storage Account Creation

$rgname="RGCI"
$locCI='Central India'
$saName="appstore090720251051"
$saKind="StorageV2"
$saSKU="Standard_LRS"


New-AzStorageAccount -ResourceGroupName $rgname -Name $saName -Location $locCI -Kind $saKind -SkuName $saSKU



### Deploying Azure Web App

$rgname="RGCI"
$locCI='Central India'
$appServicePlan="webappplan09072025"
$webappname="webapp09072025"

New-AzAppServicePlan -Location $locCI -ResourceGroupName $rgname -Name $appServicePlan -Tier Basic

New-AzWebApp -ResourceGroupName $rgname -Name $webappname -Location $locCI -AppServicePlan $appServicePlan

