output "resource_group_name" {
    value = data.azurerm_resource_group.this.name
}

output "cluster_name" {
    value = azurerm_kubernetes_cluster.this.name
}

output "get_credentials_command" {
    value = "az aks get-credentials --resource-group
    ${data.azurerm_resource_group.this.name} --name
    ${azurerm_kubernetes_cluster.this.name}"
}