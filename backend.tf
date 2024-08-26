terraform{
backend "azurerm" {
resource_group_name = "rg-vmss"
    storage_account_name = "sudhanewstorageabc"
   container_name = "tfstate"
    key = "terraform.tfstate"
}
}
