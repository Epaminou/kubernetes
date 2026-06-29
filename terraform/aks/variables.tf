variable "resource_group_name" {
    type = string
    description = "Resource group EXISTANT, fourni par l'école (renseigné dans terraform.tfvars)."
}

variable "cluster_name" {
    type = string
    default = "aks-formation" # TODO (optionnel) : vous pouvez conserver cette valeur
}

variable "node_count" {
    type = number
    default = 2 # TODO (optionnel) : 2 nœuds suffisent pour ce TP
}

variable "vm_size" {
    type = string
    default = "Standard_B2s" # taille économique (burstable), adaptée à un TP
}

variable "tags" {
    type = map(string)
    default = {
        formation = "aks"
        module = "1-fondamentaux"
    }
}