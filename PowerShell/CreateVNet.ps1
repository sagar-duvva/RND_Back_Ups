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

