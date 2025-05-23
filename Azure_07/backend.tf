terraform {
  backend "azurerm" {
    # This backend block configures the backend to use Azure Storage Account
    # The backend block is used to configure the backend for storing the Terraform state file
    # resource_group_name              = "StorageAccount-ResourceGroup"          # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    # storage_account_name             = "abcd1234"                              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    # container_name                   = "tfstate"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    # key                              = "prod.terraform.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
    # or make a prod.backend.tf file and use `-backend-config` to pass the values
  }
}
