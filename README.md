# plex-aci
Deploys Plex in a Microsoft Azure Container Instance

Install git
https://git-scm.com/downloads

Install Azure CLI
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli

Install Az module from powershellgallery
#Run PS as admin
> Set-ExecutionPolicy unrestricted
> Install-Module -Name Az -AllowClobber

Download scripts and templates
> mkdir /docker
> cd /docker
> git clone https://github.com/o-th/plex-aci
> cd plex-aci

Login to Azure accounts
#Open PS standard 
> az login
> connect-azaccount

Create resource group, storage account, and file shares
> ./az-create-plex-accounts.ps1

configure deploy-aci.yaml
#https://www.plex.tv/claim/

deploy ACI with deploy-aci.yaml
> az container create --resource-group plex --file deploy-aci.yaml
