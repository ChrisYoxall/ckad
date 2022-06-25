set -eu -o pipefail
source env.sh

############################################
# STEP 1: create Azure Resource Group
############################################
az group create \
  --resource-group $AZ_RESOURCE_GROUP \
  --location $AZ_LOCATION

############################################
# STEP 2: create network infrastructure
############################################
az network vnet create \
  --resource-group $AZ_RESOURCE_GROUP \
  --name $AZ_VNET_NAME \
  --address-prefixes $AZ_VNET_RANGE \

az network vnet subnet create \
  --resource-group $AZ_RESOURCE_GROUP \
  --vnet-name $AZ_VNET_NAME \
  --name $AZ_SUBNET_NAME \
  --address-prefixes $AZ_SUBNET_RANGE \
  
############################################
# STEP 3: create managed identity
############################################
az identity create \
  --name $AZ_AKS_IDENTITY_NAME \
  --resource-group $AZ_RESOURCE_GROUP

############################################
# STEP 4: fetch subnet and identity ids
############################################
export SUBNET_ID=$(az network vnet subnet show \
  --resource-group $AZ_RESOURCE_GROUP \
  --vnet-name $AZ_VNET_NAME \
  --name $AZ_SUBNET_NAME \
  --query id \
  --output tsv
)

echo "Subnet ID: ${SUBNET_ID}"

export AZ_AKS_IDENTITY_ID=$(az identity show \
  --resource-group ${AZ_RESOURCE_GROUP} \
  --name ${AZ_AKS_IDENTITY_NAME} \
  --query id \
  --output tsv
)

echo "Identity ID: ${AZ_AKS_IDENTITY_ID}"


############################################
# STEP 5: create Azure Kubernetes Service cluster
############################################
az aks create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_AKS_CLUSTER_NAME \
    --kubernetes-version 1.23.5 \
    --generate-ssh-keys \
    --node-vm-size standard_b4ms \
    --enable-managed-identity \
    --assign-identity $AZ_AKS_IDENTITY_ID \
    --network-plugin "azure" \
    --network-policy "calico" \
    --vnet-subnet-id $SUBNET_ID \
    --node-count 3

############################################ 
# STEP 6: create KUBECONFIG to access AKS cluster
############################################
az aks get-credentials \
  --resource-group $AZ_RESOURCE_GROUP \
  --name $AZ_AKS_CLUSTER_NAME \
  --file $KUBECONFIG