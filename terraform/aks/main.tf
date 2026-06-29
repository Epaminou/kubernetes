# Le resource group est LU (data), il n'est PAS créé ici.
data "azurerm_resource_group" "this" {
    name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "this" {
    name = var.cluster_name
    location = data.azurerm_resource_group.this.location
    resource_group_name = data.azurerm_resource_group.this.name
    dns_prefix = var.cluster_name
    
    sku_tier = "Free" # control plane managé, non facturé (sans SLA)
    
    default_node_pool {
        name = "system"
        node_count = var.node_count
        vm_size = var.vm_size

        # Reprend la valeur par défaut d'AKS : sans ce bloc, azurerm 4.x voudrait le SUPPRIMER à un plan ultérieur (ex. TP8) -> diff parasite sur le cluster.
        upgrade_settings {
            max_surge = "10%"
        }
    }
    
    identity {
        type = "SystemAssigned" # identité managée : aucun secret à gérer
    }

    # Réseau : on active un moteur de NetworkPolicy DÈS la création du cluster.
    # Sans cela, les NetworkPolicy sont acceptées mais SANS EFFET (network_policy = "none").
    # Choix volontaire, réutilisé aux modules 5 (Réseau) et 6 (Sécurité / NetworkPolicy).

    network_profile {
        network_plugin = "azure"
        network_policy = "azure"
    }

    # Le cluster hérite des étiquettes du resource group (déjà conforme à la policy), puis ajoute les siennes -> conformité automatique à « Exiger une étiquette ».
    tags = merge(data.azurerm_resource_group.this.tags, var.tags)

    # Certaines étiquettes sont (re)mutées par l'Azure Policy de l'école après création (ex. aksnumber) : on ignore leurs dérives pour garder des plans STABLES (TP8).
    # Les tags restent posés à la création (conformité policy) ; on cesse juste de les « réconcilier » ensuite.
    lifecycle {
        ignore_changes = [tags]
    }
}