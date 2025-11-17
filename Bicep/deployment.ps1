$rgn="LearnBicepRG"

az group create --location centralindia --name $rgn

az group deployment create --resource-group $rgn --template-file .\script.bicep --mode complete

az deployment group create --resource-group $rgn --template-file .\script.bicep --mode complete
az deployment group create --resource-group $rgn --template-file .\script.bicep --mode complete --verbose

# For Subscription Scope
az deployment sub create --location centralindia --template-file .\script.bicep --verbose


az group delete --resource-group $rgn


<#
Informative URLS
https://learn.microsoft.com/en-us/azure/azure-resource-manager/
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files?tabs=Bicep#related-content
#>>

