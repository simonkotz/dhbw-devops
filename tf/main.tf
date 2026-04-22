# === RESOURCE GROUP ===

resource "azurerm_resource_group" "main" {
  name     = var.name
  location = var.location
}

# === KUBERNETES CLUSTER ===

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = var.dns_prefix
  identity {
    type = "SystemAssigned"
  }
  default_node_pool {
    name       = "system"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  role_based_access_control_enabled = true
}
 

# === AUTH SERVICE ===
resource "kubernetes_manifest" "auth_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata   = { name = "auth-service", namespace = "default", labels = { app = "auth-service" } }
    spec = {
      replicas = 1
      selector = { matchLabels = { app = "auth-service" } }
      template = {
        metadata = { labels = { app = "auth-service" } }
        spec = {
          imagePullSecrets = [{ name = "ghcr-secret" }]
          containers = [{ name = "auth-service", image = "ghcr.io/simonkotz/auth-service:latest", imagePullPolicy = "Always", ports = [{ containerPort = 8080 }] }]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "auth_service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata   = { name = "auth-service", namespace = "default" }
    spec       = { selector = { app = "auth-service" }, ports = [{ port = 80, targetPort = 8080 }] }
  }
}

# === CHECKOUT SERVICE ===
resource "kubernetes_manifest" "checkout_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata   = { name = "checkout-service", namespace = "default", labels = { app = "checkout-service" } }
    spec = {
      replicas = 2
      selector = { matchLabels = { app = "checkout-service" } }
      template = {
        metadata = { labels = { app = "checkout-service" } }
        spec = {
          imagePullSecrets = [{ name = "ghcr-secret" }]
          containers = [{
            name            = "checkout-service"
            image           = "ghcr.io/simonkotz/checkout-service:latest"
            imagePullPolicy = "Always"
            ports           = [{ containerPort = 8080 }]
          }]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "checkout_service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata   = { name = "checkout-service", namespace = "default" }
    spec       = { selector = { app = "checkout-service" }, ports = [{ port = 80, targetPort = 8080 }] }
  }
}

# === PRODUCT SERVICE ===
resource "kubernetes_manifest" "product_deployment" {
  manifest = {
    apiVersion = "apps/v1"
    kind       = "Deployment"
    metadata   = { name = "product-service", namespace = "default", labels = { app = "product-service" } }
    spec = {
      replicas = 3
      selector = { matchLabels = { app = "product-service" } }
      template = {
        metadata = { labels = { app = "product-service" } }
        spec = {
          imagePullSecrets = [{ name = "ghcr-secret" }]
          containers = [{
            name            = "product-service"
            image           = "ghcr.io/simonkotz/product-service:latest"
            imagePullPolicy = "Always"
            ports           = [{ containerPort = 8080 }]
          }]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "product_service" {
  manifest = {
    apiVersion = "v1"
    kind       = "Service"
    metadata   = { name = "product-service", namespace = "default" }
    spec       = { selector = { app = "product-service" }, ports = [{ port = 80, targetPort = 8080 }] }
  }
}