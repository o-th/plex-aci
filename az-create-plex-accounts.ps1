$resourceGroupName = "plex"
$storageAccountName = "plexstorage$(Get-Random)"
$shareName = "plex-share"
$region = "westus"

az group create --name $resourceGroupName --location westus

$storAcct = New-AzStorageAccount `
    -ResourceGroupName $resourceGroupName `
    -Name $storageAccountName `
    -SkuName Standard_LRS `
    -Location $region `

New-AzRmStorageShare `
        -ResourceGroupName $resourceGroupName `
        -StorageAccountName $storageAccountName `
        -Name $shareName `
        -AccessTier Hot `
        -QuotaGiB 20 | `
    Out-Null

echo "Resource Group: $resourceGroupName"
echo "Storage Account Name: $storageAccountName"
echo "Share Name: $shareName"


(Get-AzStorageAccountKey -ResourceGroupName "$resourceGroupName" -AccountName "$storageAccountName")| Where-Object {$_.KeyName -eq "key2"}
