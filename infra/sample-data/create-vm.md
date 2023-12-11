Here is a sample az cli command that creates a VM in Azure. Keep note that the enterprise requires that we only use the eastus location and the Win2022AzureEditionCore SKU:

```bash
vmname="myVM"
username="azureuser"

az vm create \
    --resource-group $resourcegroup \
    --location eastus \
    --name $vmname \
    --image Win2022AzureEditionCore \
    --public-ip-sku Standard \
    --admin-username $username
```