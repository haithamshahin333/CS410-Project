# Deploying Kubernetes Securely

## Requirements when Deploying Azure Kubernetes Service:

1. The cluster must be private

2. You must use different node pools for different teams

3. You must use azure cni overlay when deploying the cluster

Example command to deploy:

```bash
az aks create --resource-group <resource-group-name> --name <cluster-name> --network-plugin azure --vnet-subnet-id <subnet-id> --service-cidr 10.0.0.0/16 --dns-service-ip 10.0.0.10 --docker-bridge-address 172.17.0.1/16 --generate-ssh-keys --enable-private-cluster --network-policy azure --network-plugin-mode overlay
```