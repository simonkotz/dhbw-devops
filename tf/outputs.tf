
# --- Azure Resource group ---
output "resource_group_name" {
  description = "Name der Ressource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "ID der Resource group"
  value       = azurerm_resource_group.main.id
}

# --- Kubernetes Services ---
output "auth_service_name" {
  description = "Name des Auth-Service"
  value       = kubernetes_manifest.auth_service.manifest.metadata.name
}

output "checkout_service_name" {
  description = "Name des Checkout-Service"
  value       = kubernetes_manifest.checkout_service.manifest.metadata.name
}

output "product_service_name" {
  description = "Name des Product-Service"
  value       = kubernetes_manifest.product_service.manifest.metadata.name
}