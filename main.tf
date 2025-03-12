provider "azurerm" {
  features {}
  version = "~> 3.0" # Ensure you're using the latest version
  subscription_id = "12f5b5f5-f7e8-4c0c-a65b-05187546f171"
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "my-aks-resource-group"
  location = "West Europe" # Change from "East US" to another region
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myaks"

  default_node_pool {
    name       = "agentpool"
    node_count = 1 # Reduce node count to fit available vCPU
    vm_size    = "Standard_B2s" # Use a smaller VM type
  }

  identity {
    type = "SystemAssigned"
  }
}
