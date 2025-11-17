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