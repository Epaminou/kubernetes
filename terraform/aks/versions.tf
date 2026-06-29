terraform {
    required_version = ">= 1.5.0"

    required_providers {
        azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.0"
        }
    }
    # Pas de bloc "backend" : l'état Terraform reste LOCAL (fichier terraform.tfstate).
}