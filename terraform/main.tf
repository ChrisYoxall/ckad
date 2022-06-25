
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine
# https://registry.terraform.io/modules/Azure/compute/azurerm/latest?tab=inputs

# https://registry.terraform.io/modules/Azure/manageddisk/azurerm/latest
# https://registry.terraform.io/modules/Azure/module-test-jenkins/azurerm/latest


# https://stackoverflow.com/questions/64668753/using-terraform-how-to-create-multiple-resources-of-same-type-with-unique-and-u


provider "azurerm" {
  features {}
}



resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-resources"
  location = "australiaeast"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}


module "compute" {
  source  = "Azure/compute/azurerm"
  version = "3.14.0"

  depends_on = [azurerm_subnet.subnet]

  nb_instances = var.instances
  nb_public_ip = var.instances

  resource_group_name = azurerm_resource_group.rg.name
  vnet_subnet_id      = azurerm_subnet.subnet.id

  vm_os_offer     = "0001-com-ubuntu-server-focal"
  vm_os_publisher = "canonical"
  vm_os_sku       = "20_04-lts-gen2"

  vm_size                       = "Standard_B4ms"
  enable_accelerated_networking = false

  admin_username = "chris"
  enable_ssh_key = true
  ssh_key        = "/home/chris/tmp/test_azure_vm.pub"
  remote_port    = 22

  nb_data_disk      = 1
  data_disk_size_gb = 32

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
}

