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

variable "acr_name" {
    type = string
    description = "Nom ACR UNIQUE AU MONDE (5-50 car., minuscules/chiffres)."
    validation {
        condition = can(regex("^[a-z0-9]{5,50}$", var.acr_name))
        error_message = "Nom ACR : 5 à 50 caractères, minuscules et chiffres uniquement."
    }
}