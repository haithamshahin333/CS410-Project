echo "RUNNING MAIN DEPLOY"

echo "CREATING RESOURCE GROUP"
az group create -n $RG_NAME -l $LOCATION

echo "CREATING AZURE OPENAI RESOURCE"
az cognitiveservices account create \
    --name $OPENAI_RESOURCE_NAME \
    --resource-group $RG_NAME \
    --location $LOCATION \
    --kind OpenAI \
    --sku s0 --subscription $SUBSCRIPTION

echo "CREATING STORAGE ACCOUNT"
az storage account create --name $STG_NAME \
    --resource-group $RG_NAME \
    --location eastus \
    --sku Standard_LRS \
    --kind StorageV2 \
    --allow-blob-public-access false

echo "CREATING STORAGE CONTAINER"
az storage container create --account-name $STG_NAME --name $CONTAINER_NAME

echo "UPLOADING DATA TO STORAGE ACCOUNT"
az storage blob upload-batch --destination $CONTAINER_NAME \
    --account-name $STG_NAME \
    --source ./infra/sample-data --overwrite

echo "CREATING AZURE AI SEARCH SERVICE"
az search service create \
    --name $SEARCH_NAME \
    --resource-group $RG_NAME \
    --sku Standard \
    --partition-count 1 \
    --replica-count 1 \
    --identity-type SystemAssigned

echo "CREATING COGNITIVE SERVICES MULTI ACCOUNT"
az cognitiveservices account create --name $COG_SERVICES_NAME \
    --resource-group $RG_NAME  \
    --kind CognitiveServices \
    --sku S0 --location $LOCATION --yes

echo "CREATE AZURE CONTAINER REGISTY"
az acr create --resource-group $RG_NAME \
    --name $ACR_NAME --sku Basic \
    --admin-enabled true \
    --location $LOCATION

echo "BUILD APP IMAGE ON ACR"
az acr build -r $ACR_NAME -g $RG_NAME -t tech-chat:latest ./app/.

echo "DEPLOYING WEB APP PLAN"
az appservice plan create --name $WEB_APP_PLAN_NAME \
    --resource-group $RG_NAME \
    --location $LOCATION --is-linux --sku B1

echo "DEPLOYING WEB APP"
az webapp create --name $WEB_APP_NAME \
    --plan $WEB_APP_PLAN_NAME \
    --resource-group $RG_NAME \
    --deployment-container-image-name $ACR_NAME.azurecr.io/tech-chat:latest