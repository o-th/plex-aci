# plex-aci
Deploys Plex in a Microsoft Azure Container Instance using Azure CLI for PowerShell

## Dependencies
Azure CLI for PowerShell
* https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli

Git for windows (If running git clone)
* https://git-scm.com/downloads


Az PowerShell module from powershellgallery (Run PS as admin while installing)
```
> Set-ExecutionPolicy unrestricted
> Install-Module -Name Az -AllowClobber
```


## PowerShell commands
<b>1.</b> Download scripts and templates
```
> git clone https://github.com/o-th/plex-aci
```
```
> cd plex-aci
```
<br>

<b>2.</b> Login to Azure accounts (both required for az-create-plex-accounts.ps1 to run correctly)
```
> az login
```
```
> connect-azaccount
```
<br>

<b>3.</b> Run <b>az-create-plex-accounts.ps1</b> to create resource group, storage account, and file shares.
```
> ./az-create-plex-accounts.ps1
```
<br>

<b>4.</b> Configure <b>deploy-aci.yaml</b> by updating the following values:
<br>

* <b>PLEX_CLAIM</b> value under <b>environmentVariables</b> with code from: https://www.plex.tv/claim/
```
environmentVariables:
      - name: 'PLEX_CLAIM'
        value: '<CLAIM CODE>'
```
 
 
* <b>dnsNameLabel</b> under <b>ipAddress</b>, with a regionally unqiue DNS name. (This creates dnsNameLabel.region.azurecontainer.io, setting this value to plex would result in 
plex.westus.azurecontainer.io being created.)
```
ipAddress:
    dnsNameLabel: <UniqueDNS>
```


* <b>config</b> and <b>media</b> mounts under <b>volumes</b> with storageAccountName and storageAccountKey. After running az-create-plex-accounts.ps1 this information should be displayed at the end.
```
volumes:
  - name: config
    azureFile:
      sharename: plex-share
      storageAccountName: <StorageAccountName>
      storageAccountKey: <StorageAccountKey>
  - name: media
    azureFile:
      sharename: plex-share
      storageAccountName: <StorageAccountName>
      storageAccountKey: <StorageAccountKey>
```
<br>

<b>5.</b> deploy ACI with deploy-aci.yaml
```
  > az container create --resource-group plex --file deploy-aci.yaml
```
