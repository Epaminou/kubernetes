output "resource_group_name" {
    value = data.azurerm_resource_group.this.name
}

output "cluster_name" {
    value = azurerm_kubernetes_cluster.this.name
}

output "get_credentials_command" {
    value = "az aks get-credentials --resource-group ${data.azurerm_resource_group.this.name} --name ${azurerm_kubernetes_cluster.this.name}"
}

output "acr_login_server" {
    value = azurerm_container_registry.this.login_server
}

output "acr_admin_username" {
    value = azurerm_container_registry.this.admin_username
}

output "acr_admin_password" {
    value = azurerm_container_registry.this.admin_password
    sensitive = true # masqué dans la sortie : à lire via -raw
}