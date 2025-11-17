## Deploying Public IP

$rgname="RGCI"
$locCI='Central India'
$PipName="Pip01"

New-AzPublicIpAddress -Name $PipName -ResourceGroupName $rgname -Location $locCI -Sku Standard -AllocationMethod Static
# New-AzPublicIpAddress -Name $PipName -ResourceGroupName $rgname -Location $locCI -Sku Standard -Tier Regional -AllocationMethod Static

