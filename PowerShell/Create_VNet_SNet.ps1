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