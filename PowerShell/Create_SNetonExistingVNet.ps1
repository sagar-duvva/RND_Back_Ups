## Creating Subnets on existing Virtual Network

$rgname="RGCI"
$VNetName="app-VNet"
$SNEtName="SNetA"
$SNetIPRane="10.0.0.0/24"

$VNetDetails=Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $rgname

$VNetDetails | Select-Object *

Add-AzVirtualNetworkSubnetConfig -Name $SNEtName -VirtualNetwork $VNetDetails -AddressPrefix $SNetIPRane

$VNetDetails | select *
$VNetDetails | select Subnets
$VNetDetails | select SubnetsText | fl

$VNetDetails | Set-AzVirtualNetwork