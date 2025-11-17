## Creating New Resource Group

# New-AzResourceGroup -Name "RGCI" -Location 'Central India' -Verbose


$rgname="RGCI"
$locCI='Central India'
New-AzResourceGroup -Name $rgname -Location $locCI -Verbose

Get-AzResourceGroup

Get-AzResourceGroup | select ResourceGroupName,Location | FL #Output Format List

Get-AzResourceGroup | select ResourceGroupName,Location | FT #Output Format Table