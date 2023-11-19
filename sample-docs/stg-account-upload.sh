#!/bin/bash
###
# Script to deploy storage account and upload data
###
az login --use-device-code
az group create --name $RG_NAME --location $LOCATION
az storage account create --name $STG_NAME --resource-group $RG_NAME --location $LOCATION --sku Standard_ZRS --encryption-services blob
az ad signed-in-user show --query objectId -o tsv | az role assignment create --role "Storage Blob Data Contributor" --assignee @- --scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RG_NAME/providers/Microsoft.Storage/storageAccounts/$STG_NAME"
az storage container create --account-name $STG_NAME --name $CONTAINER_NAME --auth-mode login
# interactive step
azcopy login
# upload data
azcopy copy --recursive "./vm-sample-data/*" "https://$STG_NAME.blob.core.windows.net/$CONTAINER_NAME"