terraform {

    required_version = ">= 1.6"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version ="~>4.0"
        }

        kubernetes = {
            source  = "hashicorp/kubernetes"
            version = "~> 2.0"
        }
    }
}

provider "azurerm" {
    features {}
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks"
  resource_group_name = azurerm_resource_group.this.name
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
