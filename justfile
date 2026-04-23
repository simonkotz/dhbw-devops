# Move to the directory with your *.tf files and run these commands to check versions of Terraform/OpenTofu and Azure CLI:

# Initialize OpenTofu providers
tofu init

# Show plan
tofu plan \
  -target=azurerm_resource_group.main \
  -target=azurerm_kubernetes_cluster.main 

# Apply in two steps
# Create AKS cluster
tofu apply \
  -target=azurerm_resource_group.main \
  -target=azurerm_kubernetes_cluster.main 

# Complete apply to also create manifests and services
tofu apply 

# Get kubeconfig and check status
az aks get-credentials -g $RG_NAME -n my-aks --overwrite-existing
kubectl get nodes
kubectl get deploy,svc,pods -o wide

# more info about the cluster
kubectl rollout status deploy/auth-service
kubectl rollout status deploy/checkout-service
kubectl rollout status deploy/product-service

# Destroy infrastructure
tofu destroy 

# Check RG deletion and for any remaining MC_* resource groups
az group exists -n $RG_NAME