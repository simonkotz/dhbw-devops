# variables.tf

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "name" {
  description = "Name der Ressourcengruppe"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
  default     = "westeurope"
}

variable "k8s_host" {
  description = "Kubernetes API Server URL"
  type        = string
}

variable "k8s_client_certificate" {
  description = "Kubernetes Client Certificate (base64)"
  type        = string
  sensitive   = true
}

variable "k8s_client_key" {
  description = "Kubernetes Client Key (base64)"
  type        = string
  sensitive   = true
}

variable "k8s_cluster_ca_certificate" {
  description = "Kubernetes CA Certificate (base64)"
  type        = string
  sensitive   = true
}