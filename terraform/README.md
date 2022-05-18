Terraform will use the currently logged in az account so ensure its set to the correct subscription.

Find image:  az vm image list --offer ubuntu --publisher canonical

Ubuntu 20.04:

  vm_os_offer     = "0001-com-ubuntu-server-focal"
  vm_os_publisher = "canonical"
  vm_os_sku       = "20_04-lts-gen2"

Ubuntu 22.04:

  vm_os_offer     = "0001-com-ubuntu-server-jammy"
  vm_os_publisher = "canonical"
  vm_os_sku       = "22_04-lts-gen2"