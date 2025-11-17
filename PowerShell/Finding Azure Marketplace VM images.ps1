## Find and use Azure Marketplace VM images with Azure PowerShell

# List the image publishers using Get-AzVMImagePublisher.
$locName="Central India"
Get-AzVMImagePublisher -Location $locName | Select PublisherName | ? { $_.PublisherName -like '*MicrosoftWindowsServer*'}
Get-AzVMImagePublisher -Location $locName | Select PublisherName | ? { $_.PublisherName -like '*Canonical*'}

# For a given publisher, list their offers using Get-AzVMImageOffer.
$pubName="MicrosoftWindowsServer"
$pubName="Canonical"
Get-AzVMImageOffer -Location $locName -PublisherName $pubName | Select Offer


# For a given publisher and offer, list the SKUs available using Get-AzVMImageSku.
$offerName="WindowsServer"
$offerName="ubuntu-24_04-lts"
$offerName="ubuntu"
$offerName="UbuntuServer"
Get-AzVMImageSku -Location $locName -PublisherName $pubName -Offer $offerName | Select Skus


# For a SKU, list the versions of the image using Get-AzVMImage.
$skuName="2022-datacenter"
$skuName="server"
$skuName="20_04-lts" # 18_04-lts, 20_04-lts, 22_04-lts
$skuName="18.10"
Get-AzVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Sku $skuName | Select Version


$version = "20348.3692.250509"
Get-AzVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Skus $skuName -Version $version





Get-AzVMImagePublisher -Location 'westus' | Select PublisherName | ? { $_.PublisherName -like '*microsoft-ads*'}
Get-AzVMImageOffer -Location 'westus' -PublisherName 'microsoft-ads' | Select Offer
Get-AzVMImageSku -Location 'westus' -PublisherName 'microsoft-ads' -Offer 'windows-data-scienccclelarze-vm' | Select Skus
Get-AzVMImage -Location 'westus' -PublisherName 'microsoft-ads' -Offer 'windows-data-science-vm' -Sku 'windows2016' | Select Version
Get-AzVMImage -Location "westus" -PublisherName "microsoft-ads" -Offer "windows-data-science-vm" -Skus "windows2016" -Version "20.01.10"

