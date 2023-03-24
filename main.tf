


resource "azurerm_linux_virtual_machine" "testvm" { 
name 					= "testvm"
resource_group_name 	= "testrg"
size 					= "Standart_D4s_v3"
admin_username 			= "adminuser"
location 				= azurerm_resource_group.example.location
network_interface_ids = [
	azurerm_network_interface.testvm.id
]

os_disk {
caching 			 = "ReadWrite"
storage_account_type = "Standard_LRS"
}

source_image_reference {
publisher 	= "Canonical"
offer 		= "0001-com-ubuntu-server-focal"
sku 		= "20_04-lts"
version 	= "latest"
	}
}

variable "image" {
	type = string
	default = "0001-com-ubuntu-server-focal"
	description = "image name"
}



resource "azurerm_network_interface" "testvm" {
	location 						= azurerm_resource_group.example.location
	name 	 						= "testvm"
	resource_group_name 			= "testrg"
	enable_accelerated_networking   = false
	enable_ip_forwarding = false
	
	ip_configuration {
		name 							= "internal"
		private_ip_address_allocation   = "Dynamic"
		private_ip_address_version 		= "IPv4"
		subnet_id 						= "${azurerm_subnet.test.id}"
	}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}


resource "azurerm_subnet" "test" {
  name                 = "subnetid"
  resource_group_name  = "testrg"
  virtual_network_name = "testvm"
  
} 

terraform {
	required_version = ">1.1.6"
	required_providers {
		azurerm = {
			source = "hashicorp/azurerm"
			version = "~> 3.0.2"
		}
	}
}

provider "azurerm" {
  features {}
}
