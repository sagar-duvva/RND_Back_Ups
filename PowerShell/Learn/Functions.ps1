#Functions
##### Adding, Listing, & Removing Functions #####


## Creating a Function name "MyFunction"
function MyFunction {
    Write-Output "Hello from MyFunction"
}


## Listing function
Get-ChildItem -Path 'Function:*'


## Removing function
Remove-Item function:\MyFunction



az group create --location centralindia --name LabRG --output yaml
function startlab {
    az group create --location centralindia --name LabRG --output yaml
}

function stoplab {
    az group delete --resource-group LabRG --yes --no-wait --output yaml
}

az group delete --resource-group LabRG --yes --no-wait --output yaml