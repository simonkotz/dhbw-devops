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
  default     = "austriaeast"
}

variable "aks_name" {
  description = "Name des AKS Clusters"
  type        = string
  default     = "my-aks"
}

variable "dns_prefix" {
  description = "DNS prefix für den AKS Cluster"
  type        = string
  default     = "myaks"
}

variable "node_count" {
  description = "Node-Anzahl im Default Node Pool"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "VM-Größe für die AKS Nodes"
  type        = string
  default     = "standard_b2s_v2"
}
